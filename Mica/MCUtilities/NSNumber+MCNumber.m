//
//  NSNumber+MCNumber.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSNumber+MCNumber.h"

@implementation NSNumber (MCNumber)

- (NSString *)friendlyValue
{
    if ([self integerValue] < 10000 & [self integerValue] > -10000) {
        return [NSString stringWithFormat:@"%d", [self integerValue]];
    } else {
        return [NSString stringWithFormat:@"%d万", [self integerValue] / 10000];
    }
}

+ (NSInteger)random:(NSInteger)limitNum
{
    return arc4random() % limitNum;
}
@end
