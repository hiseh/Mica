//
//  NSNumber+MCNumber.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/27.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSNumber+MCNumber.h"

@implementation NSNumber (MCNumber)
#pragma mark -
- (NSString *)friendlyString {
    if ([self integerValue] < 10000) {
        return [NSString stringWithFormat:@"%d", [self integerValue]];
    } else {
        return [NSString stringWithFormat:@"%d万", ([self integerValue] / 10000)];
    }
}

#pragma mark -
+ (NSInteger)random:(NSInteger)max {
    return arc4random() % max;
}

@end
