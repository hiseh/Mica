//
//  NSData+MCData.m
//  Mica-Example
//
//  Created by hiseh yin on 14-4-17.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSData+MCData.h"

@implementation NSData (MCData)

- (void)dictionaryWithJSON:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            success((NSDictionary *)jsonObject);
        }
    } else {
        failure(error);
    }
}
@end
