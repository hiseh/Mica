//
//  NSString+MCRegular.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/8.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Some regular methods.
 */
@interface NSString (MCRegular)

/**
 Returns a new string object that has be cleared HTML tags.
 */
- (NSString *)stringByCleanWithPattern:(NSString *)pattern;

- (BOOL)isContainPattern:(NSString *)pattern;

@end

extern NSString * const PATTERN_CHINESE;
extern NSString * const PATTERN_BLANKLINE;
extern NSString * const PATTERN_HTML;
extern NSString * const PATTERN_EMAIL;
extern NSString * const PATTERN_URL;
extern NSString * const PATTERN_POSTCODE;
extern NSString * const PATTERN_IDCARD;
extern NSString * const PATTERN_IPV4;

