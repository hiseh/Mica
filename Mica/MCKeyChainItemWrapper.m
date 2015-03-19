//
//  MCKeyChainItemWrapper.m
//  Mica-Example
//
//  Created by hiseh yin on 15/3/10.
//  Copyright (c) 2015年 hiseh. All rights reserved.
//

#import "MCKeychainItemWrapper.h"
#import <Security/Security.h>

@interface MCKeychainItemWrapper (PrivateMethods)
- (BOOL)checkOsstatusError:(OSStatus)status;
@end

@implementation MCKeychainItemWrapper

#pragma mark -
- (instancetype)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup {
    if (self = [super init]) {
        genericKeychainQuery__ = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                  (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClass
                                  , identifier, (__bridge id)kSecAttrService
                                  , identifier, (__bridge id)kSecAttrAccount
                                  , (__bridge id)kSecAttrAccessibleAfterFirstUnlock, (__bridge id)kSecAttrAccessible
                                  , nil];
    }
    return self;
}

- (BOOL)saveWithObject:(id)object {
    [self clear];
    [genericKeychainQuery__ setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKeyedSubscript:(__bridge id)kSecValueData];
    
    OSStatus result = SecItemAdd((__bridge CFDictionaryRef)genericKeychainQuery__, NULL);
    return [self checkOsstatusError:result];
}

- (BOOL)clear {
    OSStatus result = SecItemDelete((__bridge CFDictionaryRef)genericKeychainQuery__);
    return [self checkOsstatusError:result];
}

- (id)load {
    id resultObject = nil;
    CFDataRef keyData = NULL;
    
    [genericKeychainQuery__ setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [genericKeychainQuery__ setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    if (SecItemCopyMatching((__bridge CFDictionaryRef)genericKeychainQuery__, (CFTypeRef *)&keyData) == noErr) {
        @try {
            resultObject = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *exception) {
            //同志
        }
        @finally {}
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    
    return resultObject;
}

#pragma mark - 
- (BOOL)checkOsstatusError:(OSStatus)status {
    return status == noErr? YES: NO;
}

@end
