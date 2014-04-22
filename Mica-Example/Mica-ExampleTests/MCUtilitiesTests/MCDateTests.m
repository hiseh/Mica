//
//  MCDateTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+MCDate.h"

@interface MCDateTests : XCTestCase

@end

@implementation MCDateTests

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

- (void)test_timestamp
{
    NSInteger timesamp = [NSDate timestamp];
    XCTAssertTrue(timesamp > 0, @"timestamp");
}

- (void)test_dateWithString
{
    unsigned unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDate *date1 = [NSDate dateWithString:@"1980-01-01" dateTemplate:MCDateTemplateyyyyMMdd];
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:unitFlags fromDate:date1];
    XCTAssertTrue([components1 year] == 1980 && [components1 month] == 1 && [components1 day] == 1, @"1980-01-01");
    
    NSDate *date2 = [NSDate dateWithString:@"asdflkj" dateTemplate:MCDateTemplateyyyy];
    XCTAssertTrue(!date2, @"nil");
    
    NSDate *date3 = [NSDate dateWithString:@"0000-00-00" dateTemplate:MCDateTemplateyyyyMMdd];
    XCTAssertTrue(!date3, @"0000-00-00");
    
    NSDate *date4 = [NSDate dateWithString:@"1000-01-01" dateTemplate:MCDateTemplateyyyyMMdd];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:unitFlags fromDate:date4];
    XCTAssertTrue([components2 year] == 1000 && [components2 month] == 1 && [components1 day] == 1, @"10000-01-01");
}

- (void)test_diffToDate
{
    NSDate *date1 = [NSDate dateWithString:@"2014-4-22" dateTemplate:MCDateTemplateyyyyMMdd];
    NSDate *date2 = [NSDate dateWithString:@"1999-3-12" dateTemplate:MCDateTemplateyyyyMMdd];
    NSDate *date3 = [NSDate dateWithString:@"2015-3-22" dateTemplate:MCDateTemplateyyyyMMdd];
    NSDate *date4 = [NSDate dateWithString:@"2014-4-22" dateTemplate:MCDateTemplateyyyyMMdd];
    
    NSDateComponents *comps1 = [date1 diffToDate:date2];
    XCTAssertTrue([comps1 year] == -15 && [comps1 month] == -1 && [comps1 day] == -10, @"1999-3-12");
    
    NSDateComponents *comps2 = [date1 diffToDate:date3];
    XCTAssertTrue([comps2 year] == 0 && [comps2 month] == 11 && [comps2 day] == 0, @"2015-3-2");
    
    NSDateComponents *comps3 = [date1 diffToDate:date4];
    XCTAssertTrue([comps3 year] == 0 && [comps3 month] == 0 && [comps3 day] == 0, @"相同的");
}
@end
