//
//  NSData+MCSecurity.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/20.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (MCSecurity)

#pragma mark - AES
/**
 Returns a new data object made by aes encrypting.
 @param key The AES key.
 */
- (NSData *)encryptAES256WithKey:(NSString *)key;

/**
 Returns a new data object made by aes decrypting.
 @param key The AES key.
 */
- (NSData *)decryptAES256WithKey:(NSString *)key;

#pragma mark - MD5
/**
 Return a new data object encrypting with md5
 */
- (NSData *)md5;

#pragma mark - SHA
/**
 Return a new data object encrypting with sha1
 */
- (NSData *)sha1;

/**
 Return a new data object encrypting with sha512
 */
- (NSData *)sha512;

@end
