//
//  UITextView+MCTextView.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/2.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "UITextView+MCTextView.h"
#import "PlistModel.h"
#import "UIColor+MCColor.h"

@implementation UITextView (MCTextView)

+ (UITextView *)textviewFromPlistWithKey:(NSString *)key {
    PlistModel *plist = [PlistModel plistNamed:PLIST_FILE];
    NSDictionary *textviewDict = [(NSDictionary *)[plist objectForKey:@"TextView"] objectForKey:key];
    
    UITextView *textview = [[UITextView alloc] init];
    textview.font = [[textviewDict objectForKey:@"Bold"] boolValue]? [UIFont boldSystemFontOfSize:[[textviewDict objectForKey:@"FontSize"] floatValue]]: [UIFont systemFontOfSize:[[textviewDict objectForKey:@"FontSize"] floatValue]];
    {
        NSString *colorStr = [textviewDict objectForKey:@"TextColor"];
        UIColor *textColor = [UIColor colorFromHEX:colorStr];
        if (textColor) {
            textview.textColor = textColor;
        } else {
            textview.textColor = [UIColor colorFromPlistWithKey:colorStr];
        }
    }
    
    {
        NSString *colorStr = [textviewDict objectForKey:@"BackgroundColor"];
        if ([colorStr isEmpty]) {
            textview.backgroundColor = [UIColor clearColor];
        } else {
            UIColor *backgroundColor = [UIColor colorFromHEX:colorStr];
            if (backgroundColor) {
                textview.backgroundColor = backgroundColor;
            } else {
                textview.backgroundColor = [UIColor colorFromPlistWithKey:colorStr];
            }
        }
    }
    
    {
        NSDictionary *borderDict = [textviewDict objectForKey:@"Border"];
        if (borderDict) {
            {
                NSString *colorStr = [borderDict objectForKey:@"Color"];
                UIColor *borderColor = [UIColor colorFromHEX:colorStr];
                if (borderColor) {
                    textview.layer.borderColor = borderColor.CGColor;
                } else {
                    textview.layer.borderColor = [UIColor colorFromPlistWithKey:colorStr].CGColor;
                }
            }
            textview.layer.borderWidth = [[borderDict objectForKey:@"Width"] floatValue];
        }
    }
    
    float cornerRadius = [[textviewDict objectForKey:@"CornerRadius"] floatValue];
    if (cornerRadius > 0) {
        textview.layer.cornerRadius = cornerRadius;
    }
    
    if ([[textviewDict objectForKey:@"ShowClearButton"] boolValue]) {
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton setImage:[UIImage imageNamed:@"clear_button.png"] forState:UIControlStateNormal];
        clearButton.frame = CGRectMake(textview.frame.size.width - 30,
                                       textview.frame.size.height - 30,
                                       30,
                                       30);
        [clearButton addTarget:self action:@selector(clearTextView:) forControlEvents:UIControlEventTouchUpInside];
        [textview addSubview:clearButton];
    }
    
    textview.scrollEnabled = [[textviewDict objectForKey:@"ShowClearButton"] boolValue];
    
    return textview;
}

- (void)clearTextView:(UITextView *)textView
{
    textView.text = @"";
}

@end
