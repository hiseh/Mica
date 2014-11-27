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

@end
