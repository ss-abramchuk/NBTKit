//
//  NBTNumbers.m
//  NBTKit
//
//  Created by Jesús A. Álvarez on 29/11/2013.
//  Copyright (c) 2013 namedfork. All rights reserved.
//

#import "NBTNumbers.h"
#import "NBTKit+Private.h"

#define NSNUMBER_SUBCLASS(name, ctype, instanceWithX, xValue) \
@implementation name { \
    ctype _value; \
} \
+ (instancetype)instanceWithX:(ctype)value { \
    return [[name alloc] initWithBytes:&value objCType:@encode(ctype)]; \
} \
- (ctype)xValue { return _value; } \
- (instancetype)initWithBytes:(const void *)value objCType:(const char *)type { \
    if (strcmp(@encode(ctype), type)) { \
        NSString *reason = [NSString stringWithFormat:@"%@ can only be initialized with objCType %s (not %s)", \
                                NSStringFromClass([self class]), @encode(ctype), type]; \
        @throw [NSException exceptionWithName:@"NBTTypeException" reason:reason userInfo:nil]; \
    } \
    if (self = [super init]) { _value = *(ctype*)value; } \
    return self; } \
+ (NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type { return [[self alloc] initWithBytes:value objCType:type]; } \
+ (NSValue *)value:(const void *)value withObjCType:(const char *)type { return [self valueWithBytes:value objCType:type]; } \
- (void)getValue:(void *)value { *(ctype*)value = _value; } \
- (const char *)objCType NS_RETURNS_INNER_POINTER { return @encode(ctype); } \
@end

NSNUMBER_SUBCLASS(NBTByte, char, instanceWithChar, charValue)
NSNUMBER_SUBCLASS(NBTShort, int16_t, instanceWithShort, shortValue)
NSNUMBER_SUBCLASS(NBTInt, int32_t, instanceWithInt, intValue)
NSNUMBER_SUBCLASS(NBTLong, int64_t, instanceWithLong, longLongValue)
NSNUMBER_SUBCLASS(NBTFloat, float, instanceWithFloat, floatValue)
NSNUMBER_SUBCLASS(NBTDouble, double, instanceWithDouble, doubleValue)
