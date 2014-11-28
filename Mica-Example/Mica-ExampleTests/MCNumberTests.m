//
//  MCNumberTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/28.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSNumber+MCNumber.h"

@interface MCNumberTests : XCTestCase

@end

@implementation MCNumberTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_friendlyString {
    {
        NSNumber *a = @(0);
        XCTAssertEqualObjects([a friendlyString], @"0");
    }
    
    {
        NSNumber *a = @(9999);
        XCTAssertEqualObjects([a friendlyString], @"9999");
    }
    
    {
        NSNumber *a = @(10000);
        XCTAssertEqualObjects([a friendlyString], @"1万");
    }
}

@end
