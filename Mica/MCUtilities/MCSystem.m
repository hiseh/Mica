//
//  MCSystem.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-22.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCSystem.h"

//NSString * const

NSString * const Sfishfw = @"sdf";


@implementation MCSystem
@synthesize screenWidth;
@synthesize screenHeight;
@synthesize appVersion;
@synthesize systemName;
@synthesize systemVersion;
@synthesize systemLanguage;
@synthesize deviceVersion;

+ (MCSystem *)sharedInstance
{
    static dispatch_once_t onceToken;
    static MCSystem *mcSystem;
    dispatch_once(&onceToken, ^{
        mcSystem = [[self alloc] init];
        mcSystem.screenWidth = [UIScreen mainScreen].bounds.size.width;
        mcSystem.screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        mcSystem.appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        mcSystem.systemName = [[UIDevice currentDevice] systemName];
        mcSystem.systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        mcSystem.systemLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
        mcSystem.deviceVersion = [MCSystem deviceVersion];
    });
    return mcSystem;
}

+ (NSString *)deviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return deviceModel;
}
@end
