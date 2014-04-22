//
//  NSDate+MCDate.h
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MCDateTemplateyyyy = 1,
    MCDateTemplateyyyyMMdd,
    MCDateTemplateHHmm,
    MCDateTemplateMMddHHmm,
    MCDateTemplateyyyyMMddHHmm
} MCDateTemplate;

@interface NSDate (MCDate)

+ (NSDate *)dateWithString:(NSString *)string dateTemplate:(MCDateTemplate)dateTemplate;

+ (NSInteger)timestamp;
- (NSDateComponents *)diffToDate:(NSDate *)toDate;

@end
