//
//  MCRSA.h
//  Mica-Example
//
//  Created by hiseh yin on 15/1/29.
//  Copyright (c) 2015年 hiseh. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    PublicKeyFromLocal,
    PublicKeyFromRemote
} PublicKeySource;

@class BDRSACryptorKeyPair;
@class BDError;
@class BDRSACryptor;
@interface MCRSA : NSObject {
@private
    BDError *error__;
    BDRSACryptorKeyPair *RSAKeyPair__;
    NSString *identifier__;
    BDRSACryptor *rsa__;
}

- (instancetype)initWithIdntifier:(NSString *)identifier;

/**
 To generate a pair of asymnetric keys and update the publicKey & privateKey property.
 */
- (void)generateKeyPair;

/**
 export a new string with base64 encode.
 */
- (NSString *)base64PublicKey;
- (NSString *)base64PublicKeyForWEB;
- (NSString *)base64PrivateKey;

/**
 Clear the key with the self key identifier.
 */
- (BOOL)clearKeyPair;

/**
 Import RSA public key from remote.
 @param publicKeyStr a string with base64 encode.
 @return success or not.
 */
- (BOOL)importRemotePublicKey:(NSString *)publicKeyStr;

/**
 Encrypt the text with RSA public key.
 @param keySource local key or remote key.
 @param text the string that will be encrypted.
 @return the encrypted string with base64 encode.
 */
- (NSString *)encryptWithKeySource:(PublicKeySource)keySource text:(NSString *)text;

/**
 Decrypt the string that encrypted with RSA private key.
 @param encryptedText The text that encrypted.
 @return The string decrypted.
 */
- (NSString *)decrypt:(NSString *)encryptedText;

@end
