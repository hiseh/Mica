//
//  MCRSA.m
//  Mica-Example
//
//  Created by hiseh yin on 15/1/29.
//  Copyright (c) 2015年 hiseh. All rights reserved.
//
NSString * const RSA_KEY_IDENTIFIER = @"org.hiseh.rsa_key";
NSString * const RSA_PUBLIC_KEY_HEADER = @"-----BEGIN PUBLIC KEY-----";
NSString * const RSA_PUBLIC_KEY_FOOTER = @"-----END PUBLIC KEY-----";
NSString * const RSA_PRIVATE_KEY_HEADER = @"-----BEGIN RSA PRIVATE KEY-----";
NSString * const RSA_PRIVATE_KEY_FOOTER = @"-----END RSA PRIVATE KEY-----";

#import "MCRSA.h"
#import "BDRSACryptor.h"
#import "BDRSACryptorKeyPair.h"
#import "BDError.h"

@implementation MCRSA
- (instancetype)initWithIdntifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        identifier__ = identifier;
        RSAKeyPair__ = [[BDRSACryptorKeyPair alloc] init];
        rsa__ = [[BDRSACryptor alloc] init];
        rsaKeyFilePath__ = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingString:@"/mica/rsa/key/"];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:rsaKeyFilePath__
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return self;
}

#pragma mark - keychain generate and import/export
- (void)generateKeyPair {
    RSAKeyPair__ = [rsa__ generateKeyPairWithKeyIdentifier:identifier__ error:error__];
}

- (NSString *)base64PublicKey {
    return RSAKeyPair__.publicKey;
}

- (NSString *)base64PublicKeyForWEB {
    return RSAKeyPair__.exportPublicKey;
}

- (NSString *)base64PrivateKey {
    return RSAKeyPair__.privateKey;
}

- (BOOL)clearKeyPair {
    error__ = [[BDError alloc] init];
    NSString *publicKeyIdentifier = [rsa__ publicKeyIdentifierWithTag:identifier__];
    NSString *remotePublicKeyIdentifier = [self remotePublicKeyIdentifier];
    NSString *privateKeyIdentifier = [rsa__ privateKeyIdentifierWithTag:identifier__];
    [rsa__ removeKey:publicKeyIdentifier error:error__];
    [rsa__ removeKey:privateKeyIdentifier error:error__];
    [rsa__ removeKey:remotePublicKeyIdentifier error:error__];
    return ![BDError errorContainsErrors:error__];
}

- (BOOL)importRemotePublicKey:(NSString *)publicKeyStr {
    error__ = [[BDError alloc] init];
    NSString *str1, *str2, *str3, *str4;
    str1 = [publicKeyStr substringToIndex:64];
    str2 = [publicKeyStr substringWithRange:NSMakeRange(64, 64)];
    str3 = [publicKeyStr substringWithRange:NSMakeRange(128, 64)];
    str4 = [publicKeyStr substringFromIndex:192];
    
    NSString *pemStr = [NSString stringWithFormat:@"-----BEGIN PUBLIC KEY-----\n%@\n%@\n%@\n%@\n-----END PUBLIC KEY-----", str1, str2, str3, str4];
    RSAKeyPair__.remotePublicKey = pemStr;
    NSString *remotePublicKeyIdentifier = [self remotePublicKeyIdentifier];
    [rsa__ setPublicKey:pemStr tag:remotePublicKeyIdentifier error:error__];
    return ![BDError errorContainsErrors:error__];
}

- (BOOL)remotePublicKeyWriteToFile {
    if (!RSAKeyPair__.remotePublicKey || [RSAKeyPair__.remotePublicKey isEmpty]) {
        return NO;
    }
    
    NSError *error;
    return [RSAKeyPair__.remotePublicKey writeToFile:[rsaKeyFilePath__ stringByAppendingFormat:@"%@_remote_public_key", identifier__]
                                          atomically:YES
                                            encoding:NSASCIIStringEncoding
                                               error:&error];
}

- (BOOL)remotePublicKeyWithContentsOfFile {
    NSError *error;
    NSString *remotePublicKeyStr = [NSString stringWithContentsOfFile:[rsaKeyFilePath__ stringByAppendingFormat:@"%@_remote_public_key", identifier__]
                                                             encoding:NSASCIIStringEncoding
                                                                error:&error];
    if (! remotePublicKeyStr || [remotePublicKeyStr isEmpty] || error) {
        return NO;
    }
    
    RSAKeyPair__.remotePublicKey = remotePublicKeyStr;
    return YES;
}

- (BOOL)localKeyWriteToFile {
    if (!RSAKeyPair__.publicKey || !RSAKeyPair__.privateKey || [RSAKeyPair__.publicKey isEmpty] || [RSAKeyPair__.privateKey isEmpty]) {
        return NO;
    }
    
    NSError *error;
    BOOL publicKeyResult, privateKeyResult;
    publicKeyResult = [RSAKeyPair__.publicKey writeToFile:[rsaKeyFilePath__ stringByAppendingFormat:@"%@_local_public_key", identifier__]
                                               atomically:YES
                                                 encoding:NSASCIIStringEncoding
                                                    error:&error];
    privateKeyResult = [RSAKeyPair__.privateKey writeToFile:[rsaKeyFilePath__ stringByAppendingFormat:@"%@_local_private_key", identifier__]
                                                 atomically:YES
                                                   encoding:NSASCIIStringEncoding
                                                      error:&error];
    
    return publicKeyResult && privateKeyResult;
}

- (BOOL)localKeyPairWithContentsOfFile {
    NSError *publicError, *privateError;
    NSString *localPublicKeyStr = [NSString stringWithContentsOfFile:[rsaKeyFilePath__ stringByAppendingFormat:@"%@_local_public_key", identifier__]
                                                            encoding:NSASCIIStringEncoding
                                                               error:&publicError];
    NSString *localPrivateKeyStr = [NSString stringWithContentsOfFile:[rsaKeyFilePath__ stringByAppendingFormat:@"%@_local_private_key", identifier__]
                                                             encoding:NSASCIIStringEncoding
                                                                error:&privateError];
    if (! localPublicKeyStr || ! localPrivateKeyStr || [localPublicKeyStr isEmpty] || [localPrivateKeyStr isEmpty] || publicError || privateError) {
        return NO;
    }
    
    RSAKeyPair__.publicKey = localPublicKeyStr;
    RSAKeyPair__.privateKey = localPrivateKeyStr;
    return YES;
}

#pragma encrypt / decrypt
- (NSString *)encryptWithKeySource:(PublicKeySource)keySource text:(NSString *)text {
    error__ = [[BDError alloc] init];
    switch (keySource) {
        case PublicKeyFromLocal:
        {
            return [rsa__ encrypt:text key:RSAKeyPair__.publicKey error:error__];
            break;
        }
        case PublicKeyFromRemote:
        {
            return [rsa__ encrypt:text key:RSAKeyPair__.remotePublicKey error:error__];
            break;
        }
        default:
        {
            return nil;
            break;
        }
    }
    return nil;
}

- (NSString *)decrypt:(NSString *)encryptedText {
    error__ = [[BDError alloc] init];
    return [rsa__ decrypt:encryptedText
                      key:RSAKeyPair__.privateKey
                    error:error__];
    
}


#pragma mark - private methods
- (NSString *)remotePublicKeyIdentifier {
    return [[rsa__ publicKeyIdentifierWithTag:identifier__] stringByAppendingString:@".remote"];
    
}
@end