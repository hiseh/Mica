//
//  NSString+MCRegular.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/8.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

NSString * const PATTERN_CHINESE = @"[\u4e00-\u9fa5]";
NSString * const PATTERN_BLANKLINE = @"[(\n)*(\\s)*(\r)*]";
NSString * const PATTERN_HTML = @"<[^>]+>";
NSString * const PATTERN_EMAIL = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
NSString * const PATTERN_URL = @"[a-zA-z]+://\\S*";
NSString * const PATTERN_POSTCODE = @"[1-9]\\d{5}(?!\\d)";
NSString * const PATTERN_IDCARD = @"\\d{15}|\\d{18}|\\d{17}X";
NSString * const PATTERN_IPV4 = @"\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}";

#import "NSString+MCRegular.h"

@implementation NSString (MCRegular)

- (NSString *)stringByCleanWithPattern:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                       options:0
                                                                                         error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
        return nil;
    } else {
        NSString *resultStr = [regularExpression stringByReplacingMatchesInString:self
                                                                          options:NSMatchingReportProgress
                                                                            range:NSMakeRange(0, [self length])
                                                                     withTemplate:@""];
        return resultStr;
    }
}

- (BOOL)isContainPattern:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                       options:0
                                                                                         error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
        return NO;
    } else {
        NSUInteger resultNum = [regularExpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, [self length])];
        return resultNum > 0;
    }
}
@end
