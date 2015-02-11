//
//  NSData+Cryptor.h
//  Mica-Example
//
//  Created by hiseh yin on 15/2/10.
//  Copyright (c) 2015年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Cryptor)

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

@end
