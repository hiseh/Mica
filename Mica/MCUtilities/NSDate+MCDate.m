//
//  NSDate+MCDate.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSDate+MCDate.h"

@implementation NSDate (MCDate)

+ (NSDate *)dateWithString:(NSString *)string dateTemplate:(MCDateTemplate)dateTemplate
{
    if ([string isEmpty]) {
        string = @"1970-01-01";
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    switch (dateTemplate) {
        case MCDateTemplateHHmm:
        {
            [dateFormat setDateFormat:@"HH:mm"];
            break;
        }
        case MCDateTemplateMMddHHmm:
            [dateFormat setDateFormat:@"MM-dd HH:mm"];
            break;
            
        case MCDateTemplateyyyy:
            [dateFormat setDateFormat:@"yyyy"];
            break;
            
        case MCDateTemplateyyyyMMdd:
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            break;
            
        case MCDateTemplateyyyyMMddHHmm:
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
            
        default:
            break;
    }
    return [dateFormat dateFromString:string];
}

+ (NSInteger)timestamp
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    return (NSInteger)timeStamp;
}

- (NSDateComponents *)diffToDate:(NSDate *)toDate
{
    NSCalendar *sysCalendar     = [NSCalendar currentCalendar];
    unsigned int unitFlags      = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *compInfo  = [sysCalendar components:unitFlags
                                                 fromDate:self
                                                   toDate:toDate
                                                  options:0];
    return compInfo;
}
@end
