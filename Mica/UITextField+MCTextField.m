//
//  UITextField+MCTextField.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/2.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "UITextField+MCTextField.h"
#import "PlistModel.h"
#import "UIColor+MCColor.h"

@implementation UITextField (MCTextField)

+ (UITextField *)textfieldFromPlistWithKey:(NSString *)key {
    PlistModel *plist = [PlistModel plistNamed:PLIST_FILE];
    NSDictionary *textfieldDict = [(NSDictionary *)[plist objectForKey:@"TextField"] objectForKey:key];
    
    UITextField *textfield = [[UITextField alloc] init];
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.font = [[textfieldDict objectForKey:@"Bold"] boolValue]? [UIFont boldSystemFontOfSize:[[textfieldDict objectForKey:@"FontSize"] floatValue]]: [UIFont systemFontOfSize:[[textfieldDict objectForKey:@"FontSize"] floatValue]];
    {
        NSString *colorStr = [textfieldDict objectForKey:@"TextColor"];
        UIColor *textColor = [UIColor colorFromHEX:colorStr];
        if (textColor) {
            textfield.textColor = textColor;
        } else {
            textfield.textColor = [UIColor colorFromPlistWithKey:colorStr];
        }
    }
    
    {
        NSString *colorStr = [textfieldDict objectForKey:@"BackgroundColor"];
        if ([colorStr isEmpty]) {
            textfield.backgroundColor = [UIColor clearColor];
        } else {
            UIColor *backgroundColor = [UIColor colorFromHEX:colorStr];
            if (backgroundColor) {
                textfield.backgroundColor = backgroundColor;
            } else {
                textfield.backgroundColor = [UIColor colorFromPlistWithKey:colorStr];
            }
        }
    }
    
    {
        NSDictionary *borderDict = [textfieldDict objectForKey:@"Border"];
        if (borderDict) {
            {
                NSString *colorStr = [borderDict objectForKey:@"Color"];
                UIColor *borderColor = [UIColor colorFromHEX:colorStr];
                if (borderColor) {
                    textfield.layer.borderColor = borderColor.CGColor;
                } else {
                    textfield.layer.borderColor = [UIColor colorFromPlistWithKey:colorStr].CGColor;
                }
            }
            textfield.layer.borderWidth = [[borderDict objectForKey:@"Width"] floatValue];
        }
    }
    
    float cornerRadius = [[textfieldDict objectForKey:@"CornerRadius"] floatValue];
    if (cornerRadius > 0) {
        textfield.layer.cornerRadius = cornerRadius;
    }
    
    textfield.clearButtonMode = [[textfieldDict objectForKey:@"ShowClearButton"] boolValue]? UITextFieldViewModeWhileEditing: UITextFieldViewModeNever;
    
    return textfield;
    
}

@end
