//
//  NSString+MCString.h
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MCString)
typedef enum {
    OnlyLowCaseAlphabet = 0,
    OnlyAlphabet,
    NumberAndAlphabet,
    ASCIICode
} RandomStringType;

+ (NSString *)stringWithRandomWidth:(NSUInteger)width randomStringType:(RandomStringType)randomStringType;

- (BOOL)isEmpty;
- (BOOL)isSubString:(NSString *)string;
- (NSString *)substringBetween:(NSString *)beginStr endStr:(NSString *)endStr;
- (NSString *)cleanEmoji;

@end
