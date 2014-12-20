//
//  NSString+MCSecurity.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/20.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSString+MCSecurity.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MCSecurity)

#pragma mark - md5
- (NSString *)md5 {
    NSData *md5Data = [[self dataUsingEncoding:NSUTF8StringEncoding] md5];
    unsigned char *outArray = (void *)[md5Data bytes];
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", outArray[i]];
    return output;
}

@end
