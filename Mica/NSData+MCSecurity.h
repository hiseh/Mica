//
//  NSData+MCSecurity.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/20.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MCSecurity)

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

@end
