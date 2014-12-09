//
//  NSString+MCEmoji.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/9.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Emoji class.
 */
@interface NSString (MCEmoji)

/**
 Returns a new string made by removing all emoji characters of receiver.
 */
- (NSString *)stringByCleaningEmoji;

/**
 Returns a new string containing the emoji sign to display.
 */
- (NSString *)stringWithEmojiToDisplay;

/**
 Returns a new string converting the emoji sign to json.
 */
- (NSString *)stringWithEmojiToJSON;

@end
