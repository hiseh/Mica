//
//  NSData+MCAES.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/9.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MCAES)

/**
 Returns a new data object made by aes encrypting.
 @param key The AES key.
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;

/**
 Returns a new data object made by aes decrypting.
 @param key The AES key.
 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
