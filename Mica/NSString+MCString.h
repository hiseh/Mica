//
//  NSString+MCString.h
//  Mica-Example
//
//  Created by hiseh yin on 14/11/27.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#define PATTERN_HTML @"<[^>]*>|\n"  //HTML标记
typedef enum {
    OnlyAlphabet = 0,
    NumberAndAlphabet,
    ASCIICode
} RandomStringType;

#import <Foundation/Foundation.h>

@interface NSString (MCString)

- (BOOL)isEmpty;
- (BOOL)isContentSubstring:(NSString *)substring;
- (NSString *)substringBetween:(NSString *)beginStr endStr:(NSString *)endStr;
- (NSString *)stringByClearHTML;

+ (NSString *)randomString:(NSUInteger)width randomStringType:(RandomStringType)randomStringType;

@end
