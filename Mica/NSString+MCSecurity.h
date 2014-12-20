//
//  NSString+MCSecurity.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/20.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MCSecurity)

#pragma mark - MD5
/**
 Returns a new string object encrypting by md5.
 @param key The AES key.
 */
- (NSString *)md5;

/**
 Return a new string object encrypting by sha1
 */
- (NSString *)sha1;
@end
