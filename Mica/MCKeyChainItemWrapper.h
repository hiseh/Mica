//
//  MCKeyChainItemWrapper.h
//  Mica-Example
//
//  Created by hiseh yin on 15/3/10.
//  Copyright (c) 2015年 hiseh. All rights reserved.
//

extern NSString * const MC_KEYCHAINITEMWRAPPER_NOTIFICATION;

#import <Foundation/Foundation.h>
/*
 The MCKeychainItemWrapper class is an abstraction lay for the iPhone Keychain communication.
 */
@interface MCKeychainItemWrapper : NSObject {
@private
    NSMutableDictionary *genericKeychainQuery__;
}

/**
 Inits MCKeychainItemWrapper object with identifier.
 @param identifier The unique identifer of keychain.
 @param accessGroup Not used.
 @return the MCKeychainItemWrapper object.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier accessGroup:(NSString *)accessGroup;

/**
 Saves an object value to the keychain by reciever.
 @param object The object to store.
 @return boolean value.
 */
- (BOOL)saveWithObject:(id)object;

/**
 Loads a given object from the keychain by reciever.
 @return The value identified by reciever or nil if it doesn't exist.
 */
- (id)load;

/**
 Deletes the value from the keychain by reciever.
 @return YES if deletion was successful, No if the value was not found of some other error ocurred.
 */
- (BOOL)clear;

@end
