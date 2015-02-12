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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_generateKey {
    [rsa__ generateKeyPair];
    
    NSString *privateKeyStr = [rsa__ base64PrivateKey];
    NSString *publicKeyStr = [rsa__ base64PublicKey];
    [privateKeyStr writeToFile:[[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"txt"]
                    atomically:NO
                      encoding:NSUTF8StringEncoding
                         error:nil];
    [publicKeyStr writeToFile:[[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"txt"]
                   atomically:NO
                     encoding:NSUTF8StringEncoding
                        error:nil];
    
    NSLog(@"%@", [rsa__ base64PublicKey]);
    XCTAssertTrue(YES);
}

- (void)test_base64PublicKey {
    NSLog(@"public key\n%@\n", [rsa__ base64PublicKeyForWEB]);
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
    [rsa__ generateKeyPair];
    
    encryptedText__ = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    NSLog(@"加密后\n%@\n", encryptedText__);
    NSString *encrypt2 = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    NSLog(@"加密后\n%@\n", encrypt2);
    XCTAssertFalse([encryptedText__ isEmpty]);
}

- (void)test_decrypt {
    [rsa__ generateKeyPair];
    
    NSString *encrypted1 = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    NSString *encrypted2 = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    
    NSLog(@"加密后，1:\n%@\n2:\n%@", encrypted1, encrypted2);
    
    NSString *recovered1 = [[rsa__ decrypt:encrypted1] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSString *recovered2 = [[rsa__ decrypt:encrypted2] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSLog(@"解密后，1:\n%@\n2:\n%@", recovered1, recovered2);
    XCTAssertTrue([recovered1 isEqualToString:recovered2]);
}

- (void)test_writToFile {
    [rsa__ generateKeyPair];
    NSLog(@"public key:\n%@", rsa__.base64PublicKey);
    BOOL result = [rsa__ localKeyWriteToFile];
    XCTAssertTrue(result);
}

//- (void)test_decryptWithFile {
//    [rsa__ localKeyPairWithContentsOfFile];
//    NSLog(@"public key:\n%@", rsa__.base64PublicKey);
//    
//    NSString *encrypted1 = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
//    NSString *encrypted2 = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
//    
//    NSLog(@"加密后，1:\n%@\n2:\n%@", encrypted1, encrypted2);
//    
//    NSString *recovered1 = [[rsa__ decrypt:encrypted1] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
//    NSString *recovered2 = [[rsa__ decrypt:encrypted2] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
//    NSLog(@"解密后，1:\n%@\n2:\n%@", recovered1, recovered2);
//    XCTAssertTrue([recovered1 isEqualToString:recovered2]);
//    
//}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
