//
//  MCSystem.h
//  Mica-Example
//
//  Created by hiseh yin on 14-4-22.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSystem : NSObject

@property (nonatomic, assign) float screenWidth;
@property (nonatomic, assign) float screenHeight;

@property (nonatomic, assign) float appVersion;

@property (nonatomic, strong) NSString *systemName;
@property (nonatomic, assign) float systemVersion;
@property (nonatomic, strong) NSString *systemLanguage;

@property (nonatomic, strong) NSString *deviceVersion;

+ (MCSystem *)sharedInstance;

@end
