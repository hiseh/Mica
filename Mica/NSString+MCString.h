//
//  NSString+MCString.h
//  Mica-Example
//
//  Created by hiseh yin on 14/11/27.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

typedef enum {
    OnlyAlphabet = 0,
    NumberAndAlphabet,
    ASCIICode
} RandomStringType;

#import <Foundation/Foundation.h>

/**
 Some tools of NSString.
 */
@interface NSString (MCString)

/**
 Returns whether this string is empty.
 @return YES if the string is empty; otherwise, NO.
 */
- (BOOL)isEmpty;

/**
 Returns whether this string has the sub string.
 @return YES if the string has the sub string; otherwise, NO.
 */
- (BOOL)isContainSubstring:(NSString *)substring;

/**
 Returns a string object containing the characters of the receiver that lie between the begin string and the end string.
 @param beginStr A string. The string must be the sub sting of the receiver. If the string is empty, the return string will from the begin of the receiver.
 @param endStr A string. The string must be the sub string of the receiver. If the string is empty, the return string will to the end of the receiver.
 @return The sub string of the receiver.
 */
- (NSString *)substringBetween:(NSString *)beginStr endStr:(NSString *)endStr;

/**
 Returns a new string object containing the random characters.
 @param length The return string's length.
 @param randomStringType random type.
 @return A new string.
 */
+ (NSString *)randomString:(NSUInteger)length randomStringType:(RandomStringType)randomStringType;

@end
