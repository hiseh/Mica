//
//  MCSystemTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-23.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MCSystemTests : XCTestCase

@end

@implementation MCSystemTests

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

- (void)test_MCSystem
{
    MCSystem *system = [MCSystem sharedInstance];
    
    XCTAssertTrue(system.screenWidth == 320 && system.screenHeight == 480, @"screen size");
    XCTAssertTrue([system.systemLanguage isEqualToString:@"zh-Hans"], @"language");
    XCTAssertTrue([system.appVersion isEqualToString:@"0.1.0"], @"version");
}

@end
