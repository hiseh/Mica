//
//  NSString+MCSecurity.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/20.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    RSAKeyLocal = 0,
    RSAKeyString = 1
} RSAKeyType;

@interface NSString (MCSecurity)

#pragma mark - MD5
/**
 Returns a new string object encrypting by md5.
 */
- (NSString *)md5;

/**
 Returns a new string object encrypting by sha1
 */
- (NSString *)sha1;

/**
 Returns a new string object encrypting by sha512
 */
- (NSString *)sha512;

@end
