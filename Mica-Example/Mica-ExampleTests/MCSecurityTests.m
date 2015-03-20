//
//  MCSecurityTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/20.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSData+MCSecurity.h"
#import "NSString+MCSecurity.h"

@interface MCSecurityTests : XCTestCase {
@private
    NSData      *originalData__;
    NSData      *encryptData__;
    NSData      *decryptData__;
    NSString    *aesKey__;
}

@end

@implementation MCSecurityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    aesKey__ = @"1111111111111111";
    originalData__ = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - aes
- (void)test_encryptAES256WithKey {
    NSString *tempStr = @"hello";
    encryptData__ = [originalData__ encryptAES256WithKey:aesKey__];
    NSString *baseStr = [encryptData__ base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *baseStr2 = [encryptData__ base64Encoding];
    XCTAssertEqualObjects(baseStr, baseStr2);
    
//    XCTAssertEqualObjects(encryptData__, [[tempStr dataUsingEncoding:NSUTF8StringEncoding] encryptAES256WithKey:aesKey__]);
}

- (void)test_decryptAES256WithKey {
    encryptData__ = [[NSData alloc] initWithBase64Encoding:@"c7fShySWnWRn6Njacfgoxw=="];
    decryptData__ = [encryptData__ decryptAES256WithKey:aesKey__];
    NSString *result = [[[NSString alloc] initWithData:decryptData__ encoding:NSUTF8StringEncoding]
                        stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    XCTAssertEqualObjects(result, @"hello");
}

#pragma mark - md5
- (void)test_md5 {
    XCTAssertEqualObjects([aesKey__ md5], @"fa1d3eb08a879de9a4cd9995a1aa91e1");
}

- (void)test_sha1 {
    XCTAssertEqualObjects([aesKey__ sha1], @"747417f2206148a3118d02f3adf20b5e4139baac");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
