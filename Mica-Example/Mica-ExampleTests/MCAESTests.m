//
//  MCAESTests.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/18.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSData+MCAES.h"

@interface MCAESTests : XCTestCase {
@private
    NSData      *originalData__;
    NSData      *encryptData__;
    NSData      *decryptData__;
    NSString    *aesKey__;
}

@end

@implementation MCAESTests

- (void)setUp {
    [super setUp];
    aesKey__ = @"lsdfhs";
    originalData__ = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_AES256EncryptWithKey {
    NSString *tempStr = @"hello";
    encryptData__ = [originalData__ AES256EncryptWithKey:aesKey__];
    XCTAssertEqualObjects(encryptData__, [[tempStr dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:aesKey__]);
}

- (void)test_AES256DecryptWithKey {
    encryptData__ = [originalData__ AES256EncryptWithKey:aesKey__];
    decryptData__ = [encryptData__ AES256DecryptWithKey:aesKey__];
    NSString *result = [[[NSString alloc] initWithData:decryptData__ encoding:NSUTF8StringEncoding]
                        stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    XCTAssertEqualObjects(result, @"hello");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
