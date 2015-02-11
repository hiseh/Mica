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
#pragma mark -
- (NSString *)decodeEncryptData:(NSData *)encryptData length:(NSUInteger)length {
    unsigned char *outArray = (void *)[encryptData bytes];
    NSMutableString *output = [NSMutableString stringWithCapacity:length * 2];
    for(int i = 0; i < length; i++)
        [output appendFormat:@"%02x", outArray[i]];
    return output;
}

#pragma mark - md5
- (NSString *)md5 {
    NSData *md5Data = [[self dataUsingEncoding:NSUTF8StringEncoding] md5];
    return [self decodeEncryptData:md5Data length:CC_MD5_DIGEST_LENGTH];
}

#pragma mark - sha
- (NSString *)sha1 {
    NSData *sha1Data = [[self dataUsingEncoding:NSUTF8StringEncoding] sha1];
    return [self decodeEncryptData:sha1Data length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha512 {
    NSData *sha512Data = [[self dataUsingEncoding:NSUTF8StringEncoding] sha512];
    return [self decodeEncryptData:sha512Data length:CC_SHA512_DIGEST_LENGTH];
    
}

@end
