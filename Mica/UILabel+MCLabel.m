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

- (instancetype)initWithFrame:(CGRect)frame parameterKey:(NSString *)key {
    self = [super initWithFrame:frame];
    if (self) {
        PlistModel *plist = [PlistModel plistNamed:MC_PARAMETERS_FILE];
        NSDictionary *parametersDict = [(NSDictionary *)[plist objectForKey:@"Label"] objectForKey:key];
    
        self.font = [[parametersDict objectForKey:@"Bold"] boolValue]? [UIFont boldSystemFontOfSize:[[parametersDict objectForKey:@"FontSize"] floatValue]]: [UIFont systemFontOfSize:[[parametersDict objectForKey:@"FontSize"] floatValue]];
        {
            NSString *colorStr = [parametersDict objectForKey:@"TextColor"];
            UIColor *textColor = [UIColor colorFromHEX:colorStr];
            if (textColor) {
                self.textColor = textColor;
            } else {
                self.textColor = [UIColor colorFromPlistWithKey:colorStr];
            }
        }
        
        {
            NSString *colorStr = [parametersDict objectForKey:@"BackgroundColor"];
            if ([colorStr isEmpty]) {
                self.backgroundColor = [UIColor clearColor];
            } else {
                UIColor *backgroundColor = [UIColor colorFromHEX:colorStr];
                if (backgroundColor) {
                    self.backgroundColor = backgroundColor;
                } else {
                    self.backgroundColor = [UIColor colorFromPlistWithKey:colorStr];
                }
            }
        }
        
        {
            NSDictionary *borderDict = [parametersDict objectForKey:@"Border"];
            if (borderDict) {
                {
                    NSString *colorStr = [borderDict objectForKey:@"Color"];
                    UIColor *borderColor = [UIColor colorFromHEX:colorStr];
                    if (borderColor) {
                        self.layer.borderColor = borderColor.CGColor;
                    } else {
                        self.layer.borderColor = [UIColor colorFromPlistWithKey:colorStr].CGColor;
                    }
                }
                self.layer.borderWidth = [[borderDict objectForKey:@"Width"] floatValue];
            }
        }
        
        float cornerRadius = [[parametersDict objectForKey:@"CornerRadius"] floatValue];
        if (cornerRadius > 0) {
            self.layer.cornerRadius = cornerRadius;
        }
    }
    return self;
}

- (instancetype)initWithAdaptText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        self.numberOfLines = 1;
        [self sizeToFit];
    }
    return self;
}
@end
