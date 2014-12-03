//
//  UIView+MCView.h
//  Mica
//
//  Created by hiseh yin on 14/12/3.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MCShapeRect,
    MCShapeRectWithLargeCorner,
    MCShapeRectWithMiddleCorner,
    MCShapeRectWithLittleCorner,
    MCShapeRound
} MCShape;

typedef enum {
    MCGradientNone,
    MCGradientLeft2Right,
    MCGradientTop2Bottom,
    MCGradientRight2Left,
    MCGradientBottom2Top
} MCGradient;

typedef enum {
    MCTransitionCurlUP,
    MCTransitionCurlDown,
    MCTransitionFlip
} MCTransition;

/**
 *  Uiview category
 */
@interface UIView (MCView)

/**
 Create a new UIView with parameters.
 Example usage:
 @code
 [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) startColor:[UIColor whiteColor] endColor:[UIColor blackColor] borderColor:[UIColor blackColor] shapeType:MCShapeRect gradientType:MCGradientNone];
 @endcode
 @param frame
 Frame of the UIView.
 @param lightColor
 The most light color of the UIView.
 @param darkColor
 The most dark color of the UIView.
 @param borderColor
 Border color of the UIView.
 @param shape
 Which shape of UIView.
 @param gradient
 How to draw a color gradient over the UIView's background color.
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame
                       lightColor:(UIColor *)lightColor
                         darkColor:(UIColor *)darkColor
                      borderColor:(UIColor *)borderColor
                        shape:(MCShape)shape
                     gradient:(MCGradient)gradient;

/**
 Create a new horizonatal line on this UIView.
 Example usage:
 @code
 [self.view initLine:CGRectMake(0, 10, 100, 1) darkColor:[UIColor grayColor] lightColor:[UIColor whiteColor]];
 @endcode
 @param frame
 Frame of the line.
 @param lightColor
 The most light color of the UIView.
 @param darkColor
 The most dark color of the UIView.
 */
- (void)initLine:(CGRect)frame lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

#pragma mark -
/**
 Create a load more indicator.
 Example usage:
 @code
 [UIView loadMoreIndicator];
 @endcode
 @return UIView
 */
- (instancetype)initWithLoadMoreIndicator;

/**
 Create a loading indicator.
 Example usage:
 @code
 [UIView loadingIndicator];
 @endcode
 @return UIView
 */
- (instancetype)initWithLoadingIndicator;
@end
