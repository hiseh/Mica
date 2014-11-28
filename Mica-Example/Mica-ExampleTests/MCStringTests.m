//
//  MCStringTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/28.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSString+MCString.h"

@interface MCStringTests : XCTestCase

@end

@implementation MCStringTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_isEmpty {
//    NSString *a = nil;
    NSString *b = @"";
//    NSString *c = [NSString alloc];
    NSString *d = [[NSString alloc] init];
    NSString *e = @"e";
    
//    XCTAssertTrue([a isEmpty]);
    XCTAssertTrue([b isEmpty]);
//    XCTAssertTrue([c isEmpty]);
    XCTAssertTrue([d isEmpty]);
    XCTAssertFalse([e isEmpty]);
}

- (void)test_isContainSubstring{
    {
        NSString *a;
        NSString *subString;
        XCTAssertFalse([a isContainSubstring:subString]);
    }
    
    {
        NSString *a = @"";
        NSString *b = @"";
        XCTAssertFalse([a isContainSubstring:b]);
    }
    
    {
        NSString *a = @"hsf";
        NSString *b = @"";
        XCTAssertFalse([a isContainSubstring:b]);
    }
    
    {
        NSString *a = @"";
        NSString *b = @"sdf";
        XCTAssertFalse([a isContainSubstring:b]);
    }
    
    {
        NSString *a = @"sdf";
        NSString *b = @"osf";
        XCTAssertFalse([a isContainSubstring:b]);
    }
    
    {
        NSString *a = @"flish li";
        NSString *b = @"li";
        XCTAssertTrue([a isContainSubstring:b]);
    }
    
    {
        NSString *a = @"li lifs";
        NSString *b = @"li";
        XCTAssertTrue([a isContainSubstring:b]);
    }
    
    {
        NSString *a = @"sf li vh";
        NSString *b = @"li";
        XCTAssertTrue([a isContainSubstring:b]);
    }
}

@end
