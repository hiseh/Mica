//
//  MCRSATests.m
//  Mica-Example
//
//  Created by hiseh yin on 15/2/10.
//  Copyright (c) 2015年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MCRSA.h"
#import "NSString+MCString.h"

@interface MCRSATests : XCTestCase {
@private
    NSString *identifier__;
    MCRSA *rsa__;
    NSString *planText__;
    NSString *encryptedText__;
}

@end

@implementation MCRSATests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    identifier__ = @"org.hiseh.rsa_key_test";
    planText__ = @"hello";
    rsa__ = [[MCRSA alloc] initWithIdntifier:identifier__];
    [rsa__ generateKeyPair];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_base64PublicKey {
    NSLog(@"%@", [rsa__ base64PublicKey]);
    NSLog(@"%@", [rsa__ base64PublicKeyForWEB]);
    XCTAssertTrue(![[rsa__ base64PublicKeyForWEB] isEmpty]);
}

- (void)test_clearKey {
    NSString *originalPublicKey = [rsa__ base64PublicKeyForWEB];
    [rsa__ clearKeyPair];
    MCRSA *rsa2 = [[MCRSA alloc] initWithIdntifier:identifier__];
    NSString *currentPublicKey = [rsa2 base64PublicKeyForWEB];
    XCTAssertTrue(![originalPublicKey isEmpty]);
    XCTAssertFalse(currentPublicKey);
}

- (void)test_encrypt {
    encryptedText__ = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    NSLog(@"加密后\n%@\n", encryptedText__);
    XCTAssertFalse([encryptedText__ isEmpty]);
}

- (void)test_decrypt {
    encryptedText__ = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    NSString *recoveredText = [[rsa__ decrypt:encryptedText__] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSLog(@"!!!%@!!!", recoveredText);
    XCTAssertTrue([recoveredText isEqualToString:planText__]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
