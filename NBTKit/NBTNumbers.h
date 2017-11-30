//
//  NBTNumbers.h
//  NBTKit
//
//  Created by Jesús A. Álvarez on 29/11/2013.
//  Copyright (c) 2013 namedfork. All rights reserved.
//

#import <Foundation/Foundation.h>

// initializer macros for NBT Numbers
#define NBTByte(n)  [NBTByte instanceWithChar:n]
#define NBTShort(n) [NBTShort instanceWithShort:n]
#define NBTInt(n)   [NBTInt instanceWithInt:n]
#define NBTLong(n)  [NBTLong instanceWithLong:n]
#define NBTFloat(n) [NBTFloat instanceWithFloat:n]
#define NBTDouble(n)[NBTDouble instanceWithDouble:n]

/** @class NBTByte
 * Represents a NBT byte value (8-bit integer), preserving the type it was created with.
 * Created with NBTByte(value) macro
 */
@interface NBTByte : NSNumber
/**
 Create NBTByte object with provided char value

 @param value 8-bit integer
 @return instance of NBTByte object
 */
+ (instancetype)instanceWithChar:(char)value NS_SWIFT_NAME(init(with:));
@end

/** @class NBTShort
 * Represents a NBT short value (16-bit integer), preserving the type it was created with.
 * Created with NBTShort(value) macro
 */
@interface NBTShort : NSNumber
/**
 Create NBTShort object with provided short value

 @param value 16-bit integer
 @return instance of NBTShort object
 */
+ (instancetype)instanceWithShort:(int16_t)value NS_SWIFT_NAME(init(with:));
@end

/** @class NBTInt
 * Represents a NBT int value (32-bit integer), preserving the type it was created with.
 * Created with NBTInt(value) macro
 */
@interface NBTInt : NSNumber
/**
 Create NBTInt object with provided int value

 @param value 32-bit integer
 @return instance of NBTInt object
 */
+ (instancetype)instanceWithInt:(int32_t)value NS_SWIFT_NAME(init(with:));
@end

/** @class NBTLong
 * Represents a NBT long value (64-bit integer), preserving the type it was created with.
 * Created with NBTLong(value) macro
 */
@interface NBTLong : NSNumber
/**
 Create NBTLong object with provided long value

 @param value 64-bit integer
 @return instance of NBTLong object
 */
+ (instancetype)instanceWithLong:(int64_t)value NS_SWIFT_NAME(init(with:));
@end

/** @class NBTFloat
 * Represents a NBT float value (32-bit float), preserving the type it was created with.
 * Created with NBTFloat(value) macro
 */
@interface NBTFloat : NSNumber
/**
 Create NBTFloat object with provided float value

 @param value 32-bit float
 @return instance of NBTFloat object
 */
+ (instancetype)instanceWithFloat:(float)value NS_SWIFT_NAME(init(with:));
@end

/** @class NBTDouble
 * Represents a NBT double value (64-bit float), preserving the type it was created with.
 * Created with NBTDouble(value) macro
 */
@interface NBTDouble : NSNumber
/**
 Create NBTDouble object with provided double value

 @param value 64-bit float
 @return instance of NBTDouble object
 */
+ (instancetype)instanceWithDouble:(double)value NS_SWIFT_NAME(init(with:));
@end
