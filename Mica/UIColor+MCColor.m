//
//  UIColor+MCColor.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/27.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

NSString * const PLIST_FILE = @"Parameters";

#import "UIColor+MCColor.h"
#import "PlistModel.h"

@implementation UIColor (MCColor)

+ (UIColor *)colorFromPlistWithKey:(NSString *)key {
    PlistModel *plist = [PlistModel plistNamed:PLIST_FILE];
    NSDictionary *colorDict = (NSDictionary *)[plist objectForKey:@"Color"];
    NSString *hexValue = [colorDict objectForKey:key];
    
    return [UIColor colorFromHEX:hexValue];
}

+ (UIColor *)colorFromHEX:(NSString *)hexStr {
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    unsigned hex;
    BOOL success = [scanner scanHexInt:&hex];
    
    if (! success) {
        return nil;
    } else if (hexStr.length <=6) {
        return [UIColor colorFromRGB:hex alpha:1.0];
    } else {
        unsigned color = (hex & 0xFFFFFF00) >> 8;
        CGFloat alpha = 1.0 * (hex & 0xFF) / 255.0;
        return [UIColor colorFromRGB:color alpha:alpha];
    }
}

#pragma mark -
+ (UIColor *)colorFromRGB:(unsigned)rgb alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0
                           green:((float)((rgb & 0xFF00) >> 8)) / 255.0f
                            blue:((float)(rgb & 0xFF)) / 255.0f
                           alpha:alpha];
}
@end
