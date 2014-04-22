//
//  MCDataTest.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+MCData.h"

@interface MCDataTest : XCTestCase

@end

@implementation MCDataTest

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

- (void)test_dictionaryWithJSON
{
    NSError *error;
    NSDictionary *trueJsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"名字", @"name",
                              @"male", @"gender", nil];
    NSData *trueJsonData = [NSJSONSerialization dataWithJSONObject:trueJsonDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
    
    [trueJsonData dictionaryWithJSON:^(NSDictionary *dictionary) {
        NSString *nameStr = @"名字";
        NSString *genderStr = @"male";
        
        XCTAssertTrue([[dictionary objectForKey:@"name"] isEqualToString:nameStr], @"名字");
        XCTAssertTrue([[dictionary objectForKey:@"gender"] isEqualToString:genderStr], @"male");
    } failure:^(NSError *error) {
        XCTAssertEqual(&error, nil, @"有错");
    }];
}

@end
