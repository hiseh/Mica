//
//  UIView+MCView.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/3.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "UIView+MCView.h"
#import "PlistModel.h"

@implementation UIView (MCView)

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor borderColor:(UIColor *)borderColor shape:(MCShape)shape gradient:(MCGradient)gradient {
    self = [self initWithFrame:frame];
    if (self) {
        PlistModel *plist = [PlistModel plistNamed:MC_PARAMETERS_FILE];
        NSDictionary *parametersDict = (NSDictionary *)[plist objectForKey:@"UIView"];
        switch (shape) {
            case MCShapeRect:
            {
                //矩形
                self.layer.borderColor = borderColor.CGColor;
                self.layer.borderWidth = 1.0f;
                break;
            }
            case MCShapeRectWithLargeCorner:
            {
                //大圆角矩形
                self.layer.borderColor = borderColor.CGColor;
                self.layer.borderWidth = 1.0f;
                self.layer.cornerRadius = [[parametersDict objectForKey:@"LargeCorner"] floatValue];
                self.layer.masksToBounds = YES;
                break;
            }
            case MCShapeRectWithMiddleCorner:
            {
                //中圆角矩形
                self.layer.borderColor = borderColor.CGColor;
                self.layer.borderWidth = 1.0f;
                self.layer.cornerRadius = [[parametersDict objectForKey:@"MiddleCorner"] floatValue];
                self.layer.masksToBounds = YES;
                break;
            }
            case MCShapeRectWithLittleCorner:
            {
                //小圆角矩形
                self.layer.borderColor = borderColor.CGColor;
                self.layer.borderWidth = 1.0f;
                self.layer.cornerRadius = [[parametersDict objectForKey:@"LittleCorner"] floatValue];
                self.layer.masksToBounds = YES;
                break;
            }
            case MCShapeRound:
            {
                //圆形
                CGFloat diameter = frame.size.width >= frame.size.height? frame.size.height: frame.size.width;
                self.layer.masksToBounds = YES;
                self.layer.cornerRadius = diameter / 2;
                self.layer.bounds = CGRectMake(0, 0, diameter, diameter);
                self.layer.borderWidth = 1.0f;
                self.layer.borderColor = borderColor.CGColor;
                break;
            }
            default:
                break;
        }
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)lightColor.CGColor, (id)darkColor.CGColor, nil];
        switch (gradient) {
            case MCGradientTop2Bottom:
            {
                gradientLayer.startPoint = CGPointMake(0.5, 0.0);
                gradientLayer.endPoint = CGPointMake(0.5, 1.0);
                [self.layer insertSublayer:gradientLayer atIndex:0];
                break;
            }
            case MCGradientBottom2Top:
            {
                gradientLayer.startPoint = CGPointMake(0.5, 1.0);
                gradientLayer.endPoint = CGPointMake(0.5, 0.0);
                [self.layer insertSublayer:gradientLayer atIndex:0];
                break;
            }
            case MCGradientLeft2Right:
            {
                gradientLayer.startPoint = CGPointMake(0.0, 0.5);
                gradientLayer.endPoint = CGPointMake(1.0, 0.5);
                [self.layer insertSublayer:gradientLayer atIndex:0];
                break;
            }
            case MCGradientRight2Left:
            {
                gradientLayer.startPoint = CGPointMake(1.0, 0.5);
                gradientLayer.endPoint = CGPointMake(0.0, 0.5);
                [self.layer insertSublayer:gradientLayer atIndex:0];
                break;
            }
            case MCGradientNone:
            default:
            {
                self.backgroundColor = lightColor;
                break;
            }
        }
    }
    return self;
}

- (void)initLine:(CGRect)frame lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    UIView *darkLine = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x,
                                                            frame.origin.y,
                                                            frame.size.width,
                                                            frame.size.height / 2)];
    darkLine.backgroundColor = darkColor;
    [self addSubview:darkLine];
    
    UIView *lightLine = [[UIView alloc] initWithFrame:CGRectMake(darkLine.frame.origin.x,
                                                                 darkLine.frame.origin.y + darkLine.frame.size.height,
                                                                 darkLine.frame.size.width,
                                                                 darkLine.frame.size.height)];
    lightLine.backgroundColor = lightColor;
    [self addSubview:lightLine];
}

- (instancetype)initWithLoadMoreIndicator {
    self = [super init];
    if (self) {
        UILabel *moreLabel = [[UILabel alloc] initWithAdaptText:@"加载更多"];
        moreLabel.center = self.center;
        moreLabel.backgroundColor = [UIColor clearColor];
        moreLabel.textColor = [UIColor grayColor];
        moreLabel.font = [UIFont systemFontOfSize:13.0f];
        moreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:moreLabel];
    }
    return self;
}

- (instancetype)initWithLoadingIndicator {
    self = [super init];
    if (self) {
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        activityIndicatorView.center = CGPointMake(self.center.x - 20, self.center.y);
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activityIndicatorView startAnimating];
        [self addSubview:activityIndicatorView];
    
        UILabel *loadingLabel = [[UILabel alloc] initWithAdaptText:@"加载中..."];
        loadingLabel.center = CGPointMake(self.center.x + 25, self.center.y);
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor grayColor];
        loadingLabel.font = [UIFont systemFontOfSize:13.0f];
        loadingLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:loadingLabel];
    }
    return self;
}
@end
