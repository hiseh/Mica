//
//  NSString+MCString.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/27.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

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

- (BOOL)isContentSubstring:(NSString *)substring {
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

@end
