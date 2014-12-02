//
//  MCLabelTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/1.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UILabel+MCLabel.h"
#import "UIColor+MCColor.h"

@interface MCLabelTests : XCTestCase

@end

@implementation MCLabelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_labelFromPlistWithKey {
    {
        UILabel *a = [UILabel labelFromPlistWithKey:@"Title"];
        XCTAssertTrue([a isKindOfClass:[UILabel class]]);
    }
    
    {
        UILabel *b = [UILabel labelFromPlistWithKey:@"Body"];
        XCTAssertTrue([b isKindOfClass:[UILabel class]]);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
