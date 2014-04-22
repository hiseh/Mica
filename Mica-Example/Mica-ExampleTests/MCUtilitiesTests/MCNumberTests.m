//
//  MCNumberTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumber+MCNumber.h"

@interface MCNumberTests : XCTestCase

@end

@implementation MCNumberTests

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

- (void)test_friendlyValue
{
    NSNumber *num1 = [NSNumber numberWithInteger:8291];
    XCTAssertTrue([[num1 friendlyValue] isEqualToString:[num1 stringValue]], @"8291");
    
    NSNumber *num2 = [NSNumber numberWithInteger:0];
    XCTAssertTrue([[num2 friendlyValue] isEqualToString:[num2 stringValue]], @"0");
    
    NSNumber *num3 = [NSNumber numberWithInteger:-2342];
    XCTAssertTrue([[num3 friendlyValue] isEqualToString:@"-2342"], @"负数");
    
    NSNumber *num4 = [NSNumber numberWithInteger:10000];
    XCTAssertTrue([[num4 friendlyValue] isEqualToString:@"1万"], @"1万");
    
    NSNumber *num5 = [NSNumber numberWithInteger:30189743];
    XCTAssertTrue([[num5 friendlyValue] isEqualToString:@"3018万"], @"30189743");
}

- (void)test_random
{
    NSInteger rand1 = [NSNumber random:2];
    XCTAssertTrue(rand1 < 2 , @"2");
}
@end
