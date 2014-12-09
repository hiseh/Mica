//
//  NSString+MCEmoji.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/9.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "NSString+MCEmoji.h"
#import "emojis.h"

@implementation NSString (MCEmoji)

- (NSString *)stringByCleaningEmoji {
    __block NSString *resultString = self;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", uc];
                     resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", ls];
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", hs];
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", hs];
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", hs];
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", hs];
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 NSString *emojiStr = [NSString stringWithFormat:@"[U+%x]", hs];
                 resultString = [resultString stringByReplacingOccurrencesOfString:substring withString:emojiStr];
             }
         }
     }];
    return resultString;
}

- (NSString *)stringWithEmojiToDisplay {
    static dispatch_once_t onceToken;
    static NSRegularExpression *regex = nil;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"(\\[(U\\+)[a-z0-9-+_]+\\])"
                                                     options:NSRegularExpressionCaseInsensitive
                                                       error:NULL];
    });
    
    __block NSString *resultText = self;
    NSRange matchingRange = NSMakeRange(0, [resultText length]);
    [regex enumerateMatchesInString:resultText options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
            NSRange range = result.range;
            if (range.location != NSNotFound) {
                NSString *code = [self substringWithRange:range];
                NSString *unicode = [self emojiAliases][code];
                if (unicode) {
                    resultText = [resultText stringByReplacingOccurrencesOfString:code withString:unicode];
                }
            }
        }
    }];
    
    return resultText;
}

- (NSString *)stringWithEmojiToJSON {
    if ([self length] <= 0) {
        return self;
    }
    
    NSMutableString *mutableReverseString = [[NSMutableString alloc] initWithCapacity:[self length]];
    
    NSInteger i = [self length];
    while (i > 0) {
        NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:i-1];
        NSString *characterString = [self substringWithRange:range];
        [mutableReverseString appendString:characterString];
        i = range.location;
    }
    
    NSString *outputString = [mutableReverseString copy];
    return outputString;
}

#pragma mark -
- (NSDictionary *)emojiAliases {
    static NSDictionary *_emojiAliases;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emojiAliases = EMOJI_HASH;
    });
    return _emojiAliases;
}
@end
