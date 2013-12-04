//
//  NBTKitTests.m
//  NBTKitTests
//
//  Created by Jesús A. Álvarez on 29/11/2013.
//  Copyright (c) 2013 namedfork. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NBTKit.h"

static uint8_t dataSample[1000] = {
    0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,
    0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,
    0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,
    0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,
    0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,
    0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,
    0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,
    0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,
    0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,
    0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,
    0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,
    0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,
    0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,
    0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,
    0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,
    0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,
    0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,
    0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,
    0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,
    0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,
    0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,
    0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,
    0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,
    0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,
    0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30,
    0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,
    0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,
    0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,
    0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,
    0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,
    0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,
    0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,
    0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,
    0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,
    0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,
    0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,
    0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,
    0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,
    0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,
    0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,
    0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,
    0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,
    0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,
    0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,
    0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,
    0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,
    0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,
    0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,
    0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,
    0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30,
    0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,0x04,0x56,0x4e,0x50,
    0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,0x10,0x3a,0x0a,0x48,
    0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,0x58,0x5a,0x02,0x18,
    0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,0x14,0x52,0x36,0x24,
    0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,0x0c,0x22,0x42,0x08,
    0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,0x40,0x2e,0x26,0x28,
    0x34,0x4a,0x06,0x30,0x00,0x3e,0x22,0x10,0x08,0x0a,0x16,0x2c,0x4c,0x12,0x46,0x20,
    0x04,0x56,0x4e,0x50,0x5c,0x0e,0x2e,0x58,0x28,0x02,0x4a,0x38,0x30,0x32,0x3e,0x54,
    0x10,0x3a,0x0a,0x48,0x2c,0x1a,0x12,0x14,0x20,0x36,0x56,0x1c,0x50,0x2a,0x0e,0x60,
    0x58,0x5a,0x02,0x18,0x38,0x62,0x32,0x0c,0x54,0x42,0x3a,0x3c,0x48,0x5e,0x1a,0x44,
    0x14,0x52,0x36,0x24,0x1c,0x1e,0x2a,0x40,0x60,0x26,0x5a,0x34,0x18,0x06,0x62,0x00,
    0x0c,0x22,0x42,0x08,0x3c,0x16,0x5e,0x4c,0x44,0x46,0x52,0x04,0x24,0x4e,0x1e,0x5c,
    0x40,0x2e,0x26,0x28,0x34,0x4a,0x06,0x30
};

@interface NBTKitTests : XCTestCase

@end

@implementation NBTKitTests
{
    NSDictionary *bigTest;
}

- (void)setUp
{
    [super setUp];
    
    bigTest = @{
                @"nested compound test" : @{
                        @"egg": @{
                                @"name": @"Eggbert",
                                @"value": NBTFloat(0.5)
                                },
                        @"ham": @{
                                @"name": @"Hampus",
                                @"value": NBTFloat(0.75)
                                }
                        },
                @"intTest": NBTInt(2147483647),
                @"byteTest": NBTByte(127),
                @"stringTest": @"HELLO WORLD THIS IS A TEST STRING \xc3\x85\xc3\x84\xc3\x96!",
                @"listTest (long)": @[ NBTLong(11), NBTLong(12), NBTLong(13), NBTLong(14), NBTLong(15)],
                @"doubleTest": NBTDouble(0.49312871321823148),
                @"floatTest": NBTFloat(0.49823147058486938),
                @"longTest": NBTLong(9223372036854775807LL),
                @"listTest (compound)": @[
                        @{@"created-on": NBTLong(1264099775885LL), @"name" : @"Compound tag #0"},
                        @{@"created-on": NBTLong(1264099775885LL), @"name" : @"Compound tag #1"}
                        ],
                @"byteArrayTest (the first 1000 values of (n*n*255+n*7)%100, starting with n=0 (0, 62, 34, 16, 8, ...))": [NSData dataWithBytesNoCopy:dataSample length:1000 freeWhenDone:NO],
                @"shortTest": NBTShort(32767)
                };
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSString*)pathForResource:(NSString*)name
{
    return [[NSBundle bundleForClass:[self class]] pathForResource:name ofType:nil];
}

- (void)testNBTNumberTypes
{
    for (int x=-128; x < 128; x++) {
        [self testNBTNumberTypes:x];
    }
    
    float f = 12.3f;
    XCTAssertThrows([NBTInt valueWithBytes:&f objCType:@encode(float)], @"Initialize NBTInt with float");
    XCTAssertNoThrow([NBTFloat valueWithBytes:&f objCType:@encode(float)], @"Initialize NBTFloat with float");
    
    XCTAssertEqual([@3 compare:@5.2], [NBTLong(3) compare:NBTFloat(5.2)], @"comparison between different types");
}

- (void)testNBTNumberTypes:(int)x
{
    NBTByte *b1 = NBTByte(x), *b2 = NBTByte(x);
    NBTShort *s1 = NBTShort(x), *s2 = NBTShort(x);
    NBTInt *i1 = NBTInt(x), *i2 = NBTInt(x);
    NBTLong *l1 = NBTLong(x), *l2 = NBTLong(x);
    NBTFloat *f1 = NBTFloat(x), *f2 = NBTFloat(x);
    NBTDouble *d1 = NBTDouble(x), *d2 = NBTDouble(x);
    NSArray *allNumbers = @[b1, b2, s1, s2, i1, i2, l1, l2, f1, f2, d1, d2];
    
    for (int i=0; i < allNumbers.count; i+=2) {
        NSNumber *n1 = allNumbers[i];
        NSNumber *n2 = allNumbers[i+1];
        XCTAssertNotEqual(n1, n2, @"%@(%p) and %@(%p) with same value should not be identical", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
    }
    
    for (NSNumber *n1 in allNumbers) for (NSNumber *n2 in allNumbers) {
        if (n1 == n2) continue;
        XCTAssertEqualObjects(n1, n2, @"%@(%p) and %@(%p) with same value should be equal objects", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
        XCTAssertEqual(n1.charValue, n2.charValue, @"%@(%p) and %@(%p) charValue", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
        XCTAssertEqual(n1.shortValue, n2.shortValue, @"%@(%p) and %@(%p) shortValue", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
        XCTAssertEqual(n1.intValue, n2.intValue, @"%@(%p) and %@(%p) intValue", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
        XCTAssertEqual(n1.longLongValue, n2.longLongValue, @"%@(%p) and %@(%p) longLongValue", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
        XCTAssertEqual(n1.floatValue, n2.floatValue, @"%@(%p) and %@(%p) floatValue", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
        XCTAssertEqual(n1.doubleValue, n2.doubleValue, @"%@(%p) and %@(%p) doubleValue", NSStringFromClass([n1 class]), n1, NSStringFromClass([n2 class]), n2);
    }
}

- (void)testReadNBT
{
    NSMutableDictionary *root = [NBTKit NBTWithFile:[self pathForResource:@"bigtest_uncompressed.nbt"] name:NULL options:0 error:NULL];
    
    XCTAssertEqualObjects(root, bigTest, @"bigTest (read file)");
}

- (void)testWriteNBT
{
    NSData *data = [NBTKit dataWithNBT:bigTest name:@"root" options:0 error:NULL];
    NSMutableDictionary *root = [NBTKit NBTWithData:data name:NULL options:0 error:NULL];

    XCTAssertEqualObjects(root, bigTest, @"bigTest (write and read)");
}

- (void)testReadNBTCompressed
{
    NSMutableDictionary *root = [NBTKit NBTWithFile:[self pathForResource:@"bigtest.nbt"] name:NULL options:NBTCompressed error:NULL];
    
    XCTAssertEqualObjects(root, bigTest, @"bigTest (read gzip file)");
}

- (void)testWriteNBTCompressed
{
    NSData *data = [NBTKit dataWithNBT:bigTest name:nil options:NBTCompressed error:NULL];
    NSMutableDictionary *root = [NBTKit NBTWithData:data name:NULL options:NBTCompressed error:NULL];
    XCTAssertEqualObjects(root, bigTest, @"write gzip and decompress");
    
    data = [NBTKit dataWithNBT:bigTest name:nil options:NBTCompressed+NBTUseZlib error:NULL];
    root = [NBTKit NBTWithData:data name:NULL options:NBTCompressed error:NULL];
    XCTAssertEqualObjects(root, bigTest, @"write zlib and decompress");
}

- (void)testNBTIntArray
{
    int32_t testData1[] = {1,2,3,4,5,6,7,8,9,10};
    int32_t testData2[] = {1,2,7,8,9,10};
    int32_t testData3[] = {3,4,5,6};
    
    NBTIntArray *a1 = [NBTIntArray intArrayWithValues:testData1 count:sizeof(testData1)/sizeof(*testData1)];
    NBTIntArray *a2 = [NBTIntArray intArrayWithValues:testData2 count:sizeof(testData2)/sizeof(*testData2)];
    NBTIntArray *a3 = [NBTIntArray intArrayWithValues:testData3 count:sizeof(testData3)/sizeof(*testData3)];
    
    NBTIntArray *atmp = a1.copy; [atmp replaceRange:NSMakeRange(2, 4) withValues:NULL count:0];
    XCTAssertEqualObjects(a2, atmp, @"remove middle");
    
    [atmp replaceRange:NSMakeRange(2, 0) withValues:testData3 count:4];
    XCTAssertEqualObjects(a1, atmp, @"insert at middle");
    
    [atmp replaceRange:NSMakeRange(2, 4) withValues:testData3];
    XCTAssertEqualObjects(a1, atmp, @"replace same values");
    
    [atmp replaceRange:NSMakeRange(6, 4) withValues:NULL count:0];
    [atmp replaceRange:NSMakeRange(0, 2) withValues:NULL count:0];
    XCTAssertEqualObjects(a3, atmp, @"remove beginning and end");

    [atmp replaceRange:NSMakeRange(4, 0) withValues:testData1+6 count:4];
    [atmp replaceRange:NSMakeRange(0, 0) withValues:testData1 count:2];
    XCTAssertEqualObjects(a1, atmp, @"replace at beginning and end");
    
    NSMutableDictionary *bigTest2 = bigTest.mutableCopy;
    bigTest2[@"intArrayTest"] = a1;
    
    NSData *nbtData = [NBTKit dataWithNBT:bigTest2 name:nil options:0 error:NULL];
    NSMutableDictionary *bigTest3 = [NBTKit NBTWithData:nbtData name:NULL options:0 error:NULL];
    XCTAssertEqualObjects(bigTest2, bigTest3, @"write/read bigTest with added int array");
}

- (void)testMCRegion
{
    MCRegion *mcr = [[MCRegion alloc] initWithFileAtPath:[self pathForResource:@"r.0.0.mca"]];
    char tmp[] = "/tmp/test.mca.XXXXXX";
    mktemp(tmp);
    NSString *tmpPath = [NSString stringWithUTF8String:tmp];
    MCRegion *mcr2 = [[MCRegion alloc] initWithFileAtPath:tmpPath];
    
    XCTAssert(mcr2.empty, @"Newly created region file");
    
    // write mcr file
    for (int z=0; z < 32; z++) for (int x=0; x < 32; x++) {
        NSDictionary *chunk = [mcr getChunkAtX:x Z:z];
        [mcr2 setChunk:chunk atX:x Z:z];
        if (x == 0 && z == 0) XCTAssert(chunk, @"chunk 0,0");
    }
    
    XCTAssert(!mcr2.empty, @"Region file with chunks");
    
    // check chunks are equal
    BOOL chunksAllEqual = YES;
    for (int z=0; z < 32; z++) for (int x=0; x < 32; x++) {
        NSDictionary *chunk = [mcr getChunkAtX:x Z:z];
        NSDictionary *chunk2 = [mcr2 getChunkAtX:x Z:z];
        if (chunk == nil && chunk2 == nil) continue;
        if (chunk == nil || chunk2 == nil || ![chunk isEqual:chunk2]) chunksAllEqual = NO;
    }
    XCTAssert(chunksAllEqual, @"MCR chunks (create file)");
    
    // delete temporary file
    [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:NULL];
}

- (void)testMCRegionRewrite
{
    NSString *originalPath = [self pathForResource:@"r.0.0.mca"];
    char tmp[] = "/tmp/test.mca.XXXXXX";
    mktemp(tmp);
    NSString *tmpPath = [NSString stringWithUTF8String:tmp];
    
    XCTAssert([[NSFileManager defaultManager] copyItemAtPath:originalPath toPath:tmpPath error:NULL], @"copy test mcr file to tmp");
    
    // open files
    MCRegion *mcr = [[MCRegion alloc] initWithFileAtPath:originalPath];
    MCRegion *mcr2 = [[MCRegion alloc] initWithFileAtPath:tmpPath];
    
    // rewrite
    [mcr2 rewrite];
    
    // check chunks are equal
    BOOL chunksAllEqual = YES;
    for (int z=0; z < 32; z++) for (int x=0; x < 32; x++) {
        NSDictionary *chunk = [mcr getChunkAtX:x Z:z];
        NSDictionary *chunk2 = [mcr2 getChunkAtX:x Z:z];
        if (chunk == nil && chunk2 == nil) continue;
        if (chunk == nil || chunk2 == nil || ![chunk isEqual:chunk2]) chunksAllEqual = NO;
    }
    XCTAssert(chunksAllEqual, @"MCR chunks (rewrite)");
    
    // delete temporary file
    [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:NULL];
}

@end
