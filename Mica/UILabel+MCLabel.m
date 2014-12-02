//
//  UILabel+MCLabel.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/1.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "UILabel+MCLabel.h"
#import "PlistModel.h"
#import "UIColor+MCColor.h"

@implementation UILabel (MCLabel)

+ (UILabel *)labelFromPlistWithKey:(NSString *)key {
    PlistModel *plist = [PlistModel plistNamed:MC_PARAMETERS_FILE];
    NSDictionary *labelDict = [(NSDictionary *)[plist objectForKey:@"Label"] objectForKey:key];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [[labelDict objectForKey:@"Bold"] boolValue]? [UIFont boldSystemFontOfSize:[[labelDict objectForKey:@"FontSize"] floatValue]]: [UIFont systemFontOfSize:[[labelDict objectForKey:@"FontSize"] floatValue]];
    {
        NSString *colorStr = [labelDict objectForKey:@"TextColor"];
        UIColor *textColor = [UIColor colorFromHEX:colorStr];
        if (textColor) {
            label.textColor = textColor;
        } else {
            label.textColor = [UIColor colorFromPlistWithKey:colorStr];
        }
    }
    
    {
        NSString *colorStr = [labelDict objectForKey:@"BackgroundColor"];
        if ([colorStr isEmpty]) {
            label.backgroundColor = [UIColor clearColor];
        } else {
            UIColor *backgroundColor = [UIColor colorFromHEX:colorStr];
            if (backgroundColor) {
                label.backgroundColor = backgroundColor;
            } else {
                label.backgroundColor = [UIColor colorFromPlistWithKey:colorStr];
            }
        }
    }
    
    {
        NSDictionary *borderDict = [labelDict objectForKey:@"Border"];
        if (borderDict) {
            {
                NSString *colorStr = [borderDict objectForKey:@"Color"];
                UIColor *borderColor = [UIColor colorFromHEX:colorStr];
                if (borderColor) {
                    label.layer.borderColor = borderColor.CGColor;
                } else {
                    label.layer.borderColor = [UIColor colorFromPlistWithKey:colorStr].CGColor;
                }
            }
            label.layer.borderWidth = [[borderDict objectForKey:@"Width"] floatValue];
        }
    }
    
    float cornerRadius = [[labelDict objectForKey:@"CornerRadius"] floatValue];
    if (cornerRadius > 0) {
        label.layer.cornerRadius = cornerRadius;
    }
    
    return label;
}

@end
