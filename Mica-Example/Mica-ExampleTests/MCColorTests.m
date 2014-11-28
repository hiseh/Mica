//
//  MCColorTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/28.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UIColor+MCColor.h"

@interface MCColorTests : XCTestCase

@end

@implementation MCColorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_MCColor {
    {
        UIColor *a = [UIColor colorFromHEX:@"d90070"];
        UIColor *b = [UIColor colorWithRed:217.0/255.0 green:0.0 blue:112.0/255.0 alpha:1.0];
        XCTAssertEqualObjects(a, b);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
