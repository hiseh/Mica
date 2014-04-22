//
//  MCStringTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-22.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MCStringTests : XCTestCase

@end

@implementation MCStringTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_stringWithRandomWidth
{
    NSString *str1 = [NSString stringWithRandomWidth:10 randomStringType:OnlyLowCaseAlphabet];
    XCTAssertTrue([str1 length] == 10, @"OnlyLowCaseAlphabet");
    
    NSString *str2 = [NSString stringWithRandomWidth:10 randomStringType:OnlyAlphabet];
    XCTAssertTrue([str2 length] == 10, @"OnlyAlphabet");
    
    NSString *str3 = [NSString stringWithRandomWidth:10 randomStringType:NumberAndAlphabet];
    XCTAssertTrue([str3 length] == 10, @"NumberAndAlphabet");
    
    NSString *str4 = [NSString stringWithRandomWidth:10 randomStringType:ASCIICode];
    XCTAssertTrue([str4 length] == 10, @"ASCIICode");
}

- (void)test_isEmpty
{
//    NSString *str1 = [NSString alloc];
    NSString *str2 = [[NSString alloc] init];
    NSString *str3 = @"";
    NSString *str4 = @"    ";
    NSString *str5 = @"sdf";
    
//    XCTAssertTrue([str1 isEmpty], @"未初始化");
    XCTAssertTrue([str2 isEmpty], @"nil");
    XCTAssertTrue([str3 isEmpty], @"");
    XCTAssertTrue([str4 isEmpty], @"    ");
    XCTAssertTrue(![str5 isEmpty], @"sdf");
}

- (void)test_isSubString
{
    NSString *strF1 = @"";
    NSString *strS1 = @"";
    XCTAssertTrue(![strF1 isSubString:strS1], @"");
    
    NSString *strF2 = @"";
    NSString *strS2 = @"sadf";
    XCTAssertTrue(![strF2 isSubString:strS2], @"");
    
    NSString *strF3 = @"sdf";
    NSString *strS3 = @"";
    XCTAssertTrue(![strF3 isSubString:strS3], @"");
    
    NSString *strF4 = @"sdf";
    NSString *strS4 = @"ie";
    XCTAssertTrue(![strF4 isSubString:strS4], @"");
    
    NSString *strF5 = @"asdihfaoieh";
    NSString *strS5 = @"ieh";
    XCTAssertTrue([strF5 isSubString:strS5], @"");
}

- (void)test_substringBetween
{
    
}
@end
