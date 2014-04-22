//
//  NSString+MCString.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSString+MCString.h"

@implementation NSString (MCString)

+ (NSString *)stringWithRandomWidth:(NSUInteger)width randomStringType:(RandomStringType)randomStringType
{
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:width];
    switch (randomStringType) {
        case OnlyLowCaseAlphabet:
        {
            for (int i = 0; i < width; i ++) {
                char tempC = [NSNumber random:26] + 97;
                [result appendFormat:@"%c", tempC];
            }
            break;
        }
        case OnlyAlphabet:
        {
            NSString *originalStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for (int i = 0; i < width; i ++) {
                [result appendFormat:@"%c", [originalStr characterAtIndex:[NSNumber random:[originalStr length]]]];
            }
            break;
        }
        case NumberAndAlphabet:
        {
            NSString *originalStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            for (int i = 0; i < width; i ++) {
                [result appendFormat:@"%c", [originalStr characterAtIndex:[NSNumber random:[originalStr length]]]];
            }
            break;
        }
        case ASCIICode:
        {
            NSString *originalStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+|]}[{,<.>/?";
            for (int i = 0; i < width; i ++) {
                [result appendFormat:@"%c", [originalStr characterAtIndex:[NSNumber random:[originalStr length]]]];
            }
            break;
        }
        default:
            break;
    }
    return result;
}

- (BOOL)isEmpty
{
    if (!self) {
        return YES;
    }
    
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if([self length] == 0) {
        return YES;
    }
    
    if(![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    return NO;
}

- (BOOL)isSubString:(NSString *)string
{
    if ([self isEmpty] || [string isEmpty]) {
        return NO;
    } else {
        return [self rangeOfString:string].location != NSNotFound;
    }
}

- (NSString *)substringBetween:(NSString *)beginStr endStr:(NSString *)endStr
{
    NSRange rangBegin = [self rangeOfString:beginStr];
    if (rangBegin.location == NSNotFound) {
        return @"";
    }
    
    NSRange rangEnd;
    if (endStr) {
        rangEnd = [self rangeOfString:endStr
                              options:NSLiteralSearch
                                range:NSMakeRange(rangBegin.location + rangBegin.length,
                                                  self.length - rangBegin.location - rangBegin.length)];
    } else {
        rangEnd = NSMakeRange([self length], 0);
    }
    return [self substringWithRange:NSMakeRange(rangBegin.location + rangBegin.length,
                                                rangEnd.location - rangBegin.location - rangBegin.length)];
}

- (NSString *)cleanEmoji
{
    __block NSString *resultString = self;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:@""];
             }
         }
     }];
    return resultString;
}
@end
