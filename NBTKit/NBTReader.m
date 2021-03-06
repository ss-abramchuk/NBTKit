//
//  NBTReader.m
//  NBTKit
//
//  Created by Jesús A. Álvarez on 29/11/2013.
//  Copyright (c) 2013 namedfork. All rights reserved.
//

#import "NBTReader.h"
#import "NBTKit.h"
#import "NBTKit+Private.h"
#import "NBTNumbers.h"

@implementation NBTReader
{
    NSInputStream *stream;
}

- (instancetype)initWithStream:(NSInputStream *)aStream
{
    if ((self = [super init])) {
        stream = aStream;
        [stream open];
    }
    return self;
}

- (void)dealloc
{
    [stream close];
}

- (id)readRootTag:(NSString *__autoreleasing *)name error:(NSError *__autoreleasing *)error
{
    @try {
        return [self readNamedTag:name];
    }
    @catch (NSException *exception) {
        if (error) *error = [NBTKit _errorFromException:exception];
        return nil;
    }
}

- (id)readNamedTag:(NSString *__autoreleasing *)name
{
    // read tag
    uint8_t tag = [self readByte];
    if (tag == NBTTypeEnd) return [NSNull null];
    
    // read name
    NSString *tagName = self.varInteger ? [self readVarString] : [self readString];
    if (name) *name = tagName;
    
    // read payload
    return [self readTagOfType:tag];
}

- (id)readTagOfType:(NBTType)type
{
    if (type == NBTTypeByte) {
        return NBTByte([self readByte]);
    } else if (type == NBTTypeShort) {
        return NBTShort([self readShort]);
    } else if (type == NBTTypeInt) {
        return NBTInt(self.varInteger ? [self readVarInt] : [self readInt]);
    } else if (type == NBTTypeLong) {
        return NBTLong(self.varInteger ? [self readVarLong] : [self readLong]);
    } else if (type == NBTTypeFloat) {
        return NBTFloat([self readFloat]);
    } else if (type == NBTTypeDouble) {
        return NBTDouble([self readDouble]);
    } else if (type == NBTTypeByteArray) {
        return [self readByteArray];
    } else if (type == NBTTypeString) {
        return self.varInteger ? [self readVarString] : [self readString];
    } else if (type == NBTTypeList) {
        return self.varInteger ? [self readVarList] : [self readList];
    } else if (type == NBTTypeCompound) {
        return [self readCompound];
    } else if (type == NBTTypeIntArray) {
        return self.varInteger ? [self readVarIntArray] : [self readIntArray];
    } else if (type == NBTTypeLongArray) {
        return self.varInteger ? [self readVarLongArray] : [self readLongArray];
    }
    
    @throw [NSException exceptionWithName:@"NBTTypeException" reason:[NSString stringWithFormat:@"Don't know how to read tag of type %d", type] userInfo:@{@"tag": @(type)}];
}

- (void)readError
{
    NSMutableDictionary *userInfo = @{
        NSLocalizedFailureReasonErrorKey: @"Error reading NBT."
    }.mutableCopy;
    if ([stream propertyForKey:NSStreamFileCurrentOffsetKey]) {
        userInfo[NSStreamFileCurrentOffsetKey] = [stream propertyForKey:NSStreamFileCurrentOffsetKey];
    }
    if (stream.streamError) {
        userInfo[@"error"] = stream.streamError;
    }
    @throw [NSException exceptionWithName:@"NBTReadException" reason:stream.streamError.description ?: @"Error reading NBT." userInfo:userInfo];
}

#pragma mark Basic type reading

- (int8_t)readByte
{
    uint8_t buf[1];
    if ([stream read:buf maxLength:sizeof buf] != sizeof buf) [self readError];
    return buf[0];
}

- (int16_t)readShort
{
    uint8_t buf[2];
    if ([stream read:buf maxLength:sizeof buf] != sizeof buf) [self readError];
    return _littleEndian ? OSReadLittleInt16(buf, 0) : OSReadBigInt16(buf, 0);
}

- (int32_t)readInt
{
    uint8_t buf[4];
    if ([stream read:buf maxLength:sizeof buf] != sizeof buf) [self readError];
    return _littleEndian ? OSReadLittleInt32(buf, 0) : OSReadBigInt32(buf, 0);
}

- (int32_t)readVarInt
{
    uint32_t result = [self readVarUInt];
    return (int32_t)(result >> 1) ^ -(int32_t)(result & 1);
}

- (uint32_t)readVarUInt
{
    uint32_t result = 0;
    
    uint8_t bytesMax = 5;
    uint8_t bytesRead = 0;
    
    uint8_t byte = 0;
    
    do {
        if ((bytesRead > bytesMax) || [stream read:&byte maxLength:sizeof byte] < 0) {
            [self readError];
        }
        
        result |= (uint32_t)(byte & 0x7F) << bytesRead * 7;
        
        bytesRead++;
    } while ((byte & 0x80) == 0x80);
    
    return result;
}

- (int64_t)readLong
{
    uint8_t buf[8];
    if ([stream read:buf maxLength:sizeof buf] != sizeof buf) [self readError];
    return _littleEndian ? OSReadLittleInt64(buf, 0) : OSReadBigInt64(buf, 0);
}

- (int64_t)readVarLong
{
    uint64_t result = [self readVarULong];
    return (int64_t)(result >> 1) ^ -(int64_t)(result & 1);
}

- (uint64_t)readVarULong
{
    uint64_t result = 0;
    
    char bytesMax = 10;
    char bytesRead = 0;
    
    uint8_t byte = 0;
    
    do {
        if ((bytesRead > bytesMax) || [stream read:&byte maxLength:sizeof byte] < 0) {
            [self readError];
        }
        
        result |= (uint64_t)(byte & 0x7F) << bytesRead * 7;
        
        bytesRead++;
    } while ((byte & 0x80) == 0x80);
    
    return result;
}

- (float)readFloat
{
    int32_t val = [self readInt];
    return *(float*)&val;
}

- (double)readDouble
{
    int64_t val = [self readLong];
    return *(double*)&val;
}

#pragma mark - Compound type reading

- (NSMutableData*)readByteArray
{
    // length
    int32_t len = [self readInt];
    if (len < 0) [self readError];
    
    // data
    NSMutableData *data = [NSMutableData dataWithLength:len];
    if ([stream read:data.mutableBytes maxLength:data.length] != data.length) [self readError];
    
    return data;
}

- (NSString*)readString
{
    // length
    int16_t len = [self readShort];
    if (len == 0) return @"";
    if (len < 0) [self readError];
    
    // data
    uint8_t *buf = malloc(len);
    if ([stream read:buf maxLength:len] != len) {
        free(buf);
        
        [self readError];
        return nil;
    }
    
    return [[NSString alloc] initWithBytesNoCopy:buf length:len encoding:NSUTF8StringEncoding freeWhenDone:YES];
}

- (NSString*)readVarString
{
    uint32_t length = [self readVarUInt];
    if (length == 0) { return @""; }
    
    uint8_t *buffer = malloc(length);
    
    if ([stream read:buffer maxLength:length] != length) {
        free(buffer);
        
        [self readError];
        return nil;
    }
        
    return [[NSString alloc] initWithBytesNoCopy:buffer length:length encoding:NSUTF8StringEncoding freeWhenDone:YES];
}

- (NSMutableArray*)readList
{
    // type
    int8_t tag = [self readByte];
    
    // length
    int32_t len = [self readInt];
    if (len < 0) [self readError];
    
    // items
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:len];
    while (len--) {
        [list addObject:[self readTagOfType:tag]];
    }
    
    list.nbtListType = tag;
    return list;
}

- (NSMutableArray*)readVarList
{
    // type
    int8_t tag = [self readByte];
    
    // length
    int32_t len = [self readVarInt];
    if (len < 0) [self readError];
    
    // items
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:len];
    while (len--) {
        [list addObject:[self readTagOfType:tag]];
    }
    
    list.nbtListType = tag;
    return list;
}

- (NSMutableDictionary*)readCompound
{
    NSMutableDictionary *compound = [NSMutableDictionary new];
    
    for (;;) {
        NSString *name = nil;
        id obj = [self readNamedTag:&name];
        if (obj == [NSNull null]) break;
        compound[name] = obj;
    }
    
    return compound;
}

- (NBTIntArray*)readIntArray
{
    int32_t len = [self readInt];
    if (len < 0) [self readError];
    NBTIntArray *intArray = [NBTIntArray intArrayWithCount:len];
    int32_t *values = intArray.values;
    while (len--) {
        *values++ = [self readInt];
    }
    
    return intArray;
}

- (NBTIntArray*)readVarIntArray
{
    int32_t length = [self readVarInt];
    
    NBTIntArray *intArray = [NBTIntArray intArrayWithCount:length];
    int32_t *values = intArray.values;
    
    for (int32_t i = 0; i < length; i++) {
        *values++ = [self readVarInt];
    }
    
    return intArray;
}

- (NBTLongArray*)readLongArray
{
    int32_t len = [self readInt];
    if (len < 0) [self readError];
    NBTLongArray *longArray = [NBTLongArray longArrayWithCount:len];
    int64_t *values = longArray.values;
    while (len--) {
        *values++ = [self readLong];
    }
    
    return longArray;
}

- (NBTLongArray*)readVarLongArray
{
    int32_t len = [self readVarInt];
    if (len < 0) [self readError];
    NBTLongArray *longArray = [NBTLongArray longArrayWithCount:len];
    int64_t *values = longArray.values;
    while (len--) {
        *values++ = [self readVarLong];
    }
    
    return longArray;
}

@end
