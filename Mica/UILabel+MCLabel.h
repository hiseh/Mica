//
//  UILabel+MCLabel.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/1.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MCLabel)

- (instancetype)initWithFrame:(CGRect)frame parameterKey:(NSString *)key;

/**
 Create a new label with size to fit font.
 Example usage:
 @code
 [[UILabel alloc] initWithAdaptText:@"adapt text"];
 @endcode
 @param text
 Text of the label.
 @return UILabel
 */
- (instancetype)initWithAdaptText:(NSString *)text;
@end
