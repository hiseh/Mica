//
//  MCRegularTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/9.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+MCRegular.h"
#import "NSString+MCString.h"

@interface MCRegularTests : XCTestCase {
@private
    NSString *chinese0;
    NSString *chinese1;
    
    NSString *blankLine0;
    NSString *blankLine1;
    NSString *blankLine2;
    
    NSString *html0;
    NSString *html1;
    NSString *html2;
    NSString *html3;
    
    NSString *email0;
    NSString *email1;
    NSString *email2;
    NSString *email3;
    NSString *email4;
    
    NSString *url0;
    NSString *url1;
    NSString *url2;
    NSString *url3;
    NSString *url4;
    NSString *url5;
    NSString *url6;
}

@end

@implementation MCRegularTests

- (void)setUp {
    [super setUp];
    {
        chinese0 = @"sdfov";
        chinese1 = @"h哈喽ello";
    }
    
    {
        blankLine0 = @"   ";
        blankLine1 = @"\n   \r";
        blankLine2 = @"flish\r";
    }
    
    {
        html0 = @"<slfieh<fl";
        html1 = @"<b>hello</b>";
        html2 = @"<a href=\"http://baidsu.com\">baidu</a>";
        html3 = @"<>lsf</23>";
    }
    
    {
        email0 = @"yinshufeng@idoukou.com";
        email1 = @"@hello.com";
        email2 = @"yinshufeng@";
        email3 = @"hlsieh";
        email4 = @"hello yinshufeng@idoukou.com ok";
    }
    
    {
        url0 = @"http://www.idoukou.com";
        url1 = @"http://sdf";
        url2 = @"//slifeh";
        url3 = @"sdfas.df";
        url4 = @"http://lsif.ifh.oshe.cohs.com";
        url5 = @"http://www..idoukou.com";
        url6 = @"hello http://www.idoukou.com helix";
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_stringByCleanWithPattern {
    {
        XCTAssertEqualObjects([chinese0 stringByCleanWithPattern:PATTERN_CHINESE], @"sdfov");
        XCTAssertEqualObjects([chinese1 stringByCleanWithPattern:PATTERN_CHINESE], @"hello");
    }
    
    {
        XCTAssertTrue([[blankLine0 stringByCleanWithPattern:PATTERN_BLANKLINE] isEmpty]);
        XCTAssertTrue([[blankLine1 stringByCleanWithPattern:PATTERN_BLANKLINE] isEmpty]);
        XCTAssertEqualObjects([blankLine2 stringByCleanWithPattern:PATTERN_BLANKLINE], @"flish");
    }
    
    {
        XCTAssertEqualObjects([html0 stringByCleanWithPattern:PATTERN_HTML], @"<slfieh<fl");
        XCTAssertTrue([[html1 stringByCleanWithPattern:PATTERN_HTML] isEqualToString:@"hello"]);
        XCTAssertTrue([[html2 stringByCleanWithPattern:PATTERN_HTML] isEqualToString:@"baidu"]);
        XCTAssertEqualObjects([html3 stringByCleanWithPattern:PATTERN_HTML], @"<>lsf");
    }
    
    {
        XCTAssertTrue([[email0 stringByCleanWithPattern:PATTERN_EMAIL] isEmpty]);
        XCTAssertEqualObjects([email1 stringByCleanWithPattern:PATTERN_EMAIL], @"@hello.com");
        XCTAssertEqualObjects([email2 stringByCleanWithPattern:PATTERN_EMAIL], @"yinshufeng@");
        XCTAssertEqualObjects([email3 stringByCleanWithPattern:PATTERN_EMAIL], @"hlsieh");
        XCTAssertEqualObjects([email4 stringByCleanWithPattern:PATTERN_EMAIL], @"hello  ok");
    }
    
    {
        XCTAssertTrue([[url0 stringByCleanWithPattern:PATTERN_URL] isEmpty]);
        XCTAssertTrue([[url1 stringByCleanWithPattern:PATTERN_URL] isEmpty]);
        XCTAssertEqualObjects([url2 stringByCleanWithPattern:PATTERN_URL], @"//slifeh");
        XCTAssertEqualObjects([url3 stringByCleanWithPattern:PATTERN_URL], @"sdfas.df");
        XCTAssertTrue([[url4 stringByCleanWithPattern:PATTERN_URL] isEmpty]);
        XCTAssertTrue([[url5 stringByCleanWithPattern:PATTERN_URL] isEmpty]);
        XCTAssertEqualObjects([url6 stringByCleanWithPattern:PATTERN_URL], @"hello  helix");
    }
    
}

- (void)test_isContainPattern {
    {
        XCTAssertFalse([chinese0 isContainPattern:PATTERN_CHINESE]);
        XCTAssertTrue([chinese1 isContainPattern:PATTERN_CHINESE]);
    }
    
    {
        XCTAssertTrue([blankLine0 isContainPattern:PATTERN_BLANKLINE]);
        XCTAssertTrue([blankLine1 isContainPattern:PATTERN_BLANKLINE]);
        XCTAssertTrue([blankLine2 isContainPattern:PATTERN_BLANKLINE]);
    }
    
    {
        XCTAssertFalse([html0 isContainPattern:PATTERN_HTML]);
        XCTAssertTrue([html1 isContainPattern:PATTERN_HTML]);
        XCTAssertTrue([html2 isContainPattern:PATTERN_HTML]);
        XCTAssertTrue([html3 isContainPattern:PATTERN_HTML]);
    }
    
    {
        XCTAssertTrue([email0 isContainPattern:PATTERN_EMAIL]);
        XCTAssertFalse([email1 isContainPattern:PATTERN_EMAIL]);
        XCTAssertFalse([email2 isContainPattern:PATTERN_EMAIL]);
        XCTAssertFalse([email3 isContainPattern:PATTERN_EMAIL]);
        XCTAssertTrue([email4 isContainPattern:PATTERN_EMAIL]);
    }
    
    {
        XCTAssertTrue([url0 isContainPattern:PATTERN_URL]);
        XCTAssertTrue([url1 isContainPattern:PATTERN_URL]);
        XCTAssertFalse([url2 isContainPattern:PATTERN_URL]);
        XCTAssertFalse([url3 isContainPattern:PATTERN_URL]);
        XCTAssertTrue([url4 isContainPattern:PATTERN_URL]);
        XCTAssertTrue([url5 isContainPattern:PATTERN_URL]);
        XCTAssertTrue([url6 isContainPattern:PATTERN_URL]);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
