//
//  NSData+MCData.h
//  Mica-Example
//
//  Created by hiseh yin on 14-4-17.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MCData)

- (void)dictionaryWithJSON:(void (^)(NSDictionary *dictionary))success failure:(void (^)(NSError *error))failure;

@end
