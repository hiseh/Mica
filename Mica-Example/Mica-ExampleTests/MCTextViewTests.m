//
//  MCTextViewTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/2.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UITextView+MCTextView.h"

@interface MCTextViewTests : XCTestCase

@end

@implementation MCTextViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_textviewFromPlistWithKey {
    UITextView *a = [UITextView textviewFromPlistWithKey:@"Normal"];
    XCTAssertTrue([a isKindOfClass:[UITextView class]]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
