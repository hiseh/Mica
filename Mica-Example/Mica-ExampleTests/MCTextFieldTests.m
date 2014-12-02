//
//  MCTextFieldTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/2.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UITextField+MCTextField.h"

@interface MCTextFieldTests : XCTestCase

@end

@implementation MCTextFieldTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_textfieldFromPlistWithKey {
    UITextField *a = [UITextField textfieldFromPlistWithKey:@"Signup"];
    XCTAssertTrue([a isKindOfClass:[UITextField class]]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
