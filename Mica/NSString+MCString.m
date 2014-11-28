//
//  NSString+MCString.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/27.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

NSString * const PATTERN_HTML = @"<[^>]*>|\n";  //HTML标记

#import "NSString+MCString.h"

@implementation NSString (MCString)

#pragma mark - private
- (BOOL)isEmpty {
    if (self == nil) {
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

- (BOOL)isContainSubstring:(NSString *)substring {
    if ([self isEmpty] || [substring isEmpty]) {
        return NO;
    } else {
        return [self rangeOfString:substring].location != NSNotFound;
    }
}

- (NSString *)substringBetween:(NSString *)beginStr endStr:(NSString *)endStr {
    NSRange rangBegin;
    if ([beginStr isEmpty]) {
        rangBegin = NSMakeRange(0, 0);
    } else {
        rangBegin = [self rangeOfString:beginStr];
    }
    
    if (rangBegin.location == NSNotFound) {
        return @"";
    }
    
    NSRange rangEnd;
    if (![endStr isEmpty]) {
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

- (NSString *)stringByClearHTML
{
    NSString *text = self;
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:PATTERN_HTML
                                                                                      options:0
                                                                                        error:nil];
    
    text = [regularExpretion stringByReplacingMatchesInString:text
                                                      options:NSMatchingReportProgress
                                                        range:NSMakeRange(0, [text length])
                                                 withTemplate:@""];
    
    NSRegularExpression *regular2 = [NSRegularExpression regularExpressionWithPattern:@"&[^\S]*;"
                                                                              options:0
                                                                                error:nil];
    text = [regular2 stringByReplacingMatchesInString:text
                                              options:NSMatchingReportProgress
                                                range:NSMakeRange(0, [text length])
                                         withTemplate:@""];
    return text;
}

#pragma mark -
+ (NSString *)randomString:(NSUInteger)width randomStringType:(RandomStringType)randomStringType {
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:width];
    switch (randomStringType) {
        case OnlyAlphabet:
            for (int i = 0; i < width; i ++) {
                char tempC = [NSNumber random:26] + 97;
                [result appendFormat:@"%c", tempC];
            }
            break;
        default:
            break;
    }
    return result;
}

@end
