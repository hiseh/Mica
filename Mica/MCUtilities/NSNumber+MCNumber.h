//
//  NSNumber+MCNumber.h
//  Mica-Example
//
//  Created by hiseh yin on 14-4-21.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (MCNumber)

- (NSString *)friendlyValue;

+ (NSInteger)random:(NSInteger)limitNum;

@end
