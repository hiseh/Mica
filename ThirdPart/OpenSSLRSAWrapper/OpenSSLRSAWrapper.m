// OpenSSLRSAWrapper.m
// Version 3.0
//
// Copyright (c) 2012 scott ban ( http://github.com/reference )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "OpenSSLRSAWrapper.h"
//#import "NSString+Base64.h"
//#import "NSData+Base64.h"

#define DocumentsDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define OpenSSLRSAKeyDir [DocumentsDir stringByAppendingPathComponent:@".openssl_rsa"]
#define OpenSSLRSAPublicKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"publicKey.pem"]
#define OpenSSLRSAPrivateKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"privateKey.pem"]

@implementation OpenSSLRSAWrapper
@synthesize publicKeyBase64,privateKeyBase64;

#pragma mark - getter

// Helper function for ASN.1 encoding

size_t encodeLength(unsigned char * buf, size_t length) {
    
    // encode length in ASN.1 DER format
    if (length < 128) {
        buf[0] = length;
        return 1;
    }
    
    size_t i = (length / 256) + 1;
    buf[0] = i + 0x80;
    for (size_t j = 0 ; j < i; ++j) {
        buf[i - j] = length & 0xFF;
        length = length >> 8;
    }
    
    return i + 1;
}

- (NSData*)publicKeyBitsWithString:(NSString*)str{
    
    static const unsigned char _encodedRSAEncryptionOID[15] = {
        
        /* Sequence of length 0xd made up of OID followed by NULL */
        0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00
        
    };
    
//    NSData *publicKeyBits_ = [str base64DecodedData];
    NSData *publicKeyBits_ = [[NSData alloc] initWithBase64Encoding:str];
    
    // OK - that gives us the "BITSTRING component of a full DER
    // encoded RSA public key - we now need to build the rest
    
    unsigned char builder[15];
    NSMutableData * encKey = [NSMutableData dataWithCapacity:0];
    int bitstringEncLength;
    
    // When we get to the bitstring - how will we encode it?
    if ([publicKeyBits_ length] + 1 < 128)
        bitstringEncLength = 1;
    else
        bitstringEncLength = (([publicKeyBits_ length] +1) / 256) + 2;
    
    // Overall we have a sequence of a certain length
    builder[0] = 0x30;    // ASN.1 encoding representing a SEQUENCE
    // Build up overall size made up of -
    // size of OID + size of bitstring encoding + size of actual key
    size_t i = sizeof(_encodedRSAEncryptionOID) + 2 + bitstringEncLength +
    [publicKeyBits_ length];
    size_t j = encodeLength(&builder[1], i);
    [encKey appendBytes:builder length:j +1];
    
    // First part of the sequence is the OID
    [encKey appendBytes:_encodedRSAEncryptionOID
                 length:sizeof(_encodedRSAEncryptionOID)];
    
    // Now add the bitstring
    builder[0] = 0x03;
    j = encodeLength(&builder[1], [publicKeyBits_ length] + 1);
    builder[j+1] = 0x00;
    [encKey appendBytes:builder length:j + 2];
    
    // Now the actual key
    [encKey appendData:publicKeyBits_];
    
    return encKey;
}

- (NSString*)publicKeyBase64{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:OpenSSLRSAPublicKeyFile]) {
        NSString *str = [NSString stringWithContentsOfFile:OpenSSLRSAPublicKeyFile encoding:NSUTF8StringEncoding error:nil];
        
        /*
         This return value based on the key that generated by openssl.
         
         -----BEGIN RSA PUBLIC KEY-----
         MIGHAoGBAOp5TLclpWCaNDzHYPfB26SLmS8vlSXH4PyKopz5OS5Vx994FBQQLwv9
         2pIJQsBk09egrL0gbASK1VCwDt0MmaiyrNFl/xaEzB/VOvjoojBUzMMIca9fKmx5
         GAzSbSP7we64dhvrziuuNVTuM/e2XSa2skKFHMI0bCq4+pNYhvRhAgED
         -----END RSA PUBLIC KEY-----
         */
        NSData *data = [self publicKeyBitsWithString:[[str componentsSeparatedByString:@"-----"] objectAtIndex:2]];
        
//        return [data base64EncodedString];
        return [data base64Encoding];
    }
    return nil;
}

- (NSString*)privateKeyBase64{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:OpenSSLRSAPrivateKeyFile]) {
        NSString *str = [NSString stringWithContentsOfFile:OpenSSLRSAPrivateKeyFile encoding:NSUTF8StringEncoding error:nil];
        
        /*
         This return value based on the key that generated by openssl.
         
         -----BEGIN RSA PRIVATE KEY-----
         MIICXAIBAAKBgQDqeUy3JaVgmjQ8x2D3wduki5kvL5Ulx+D8iqKc+TkuVcffeBQU
         EC8L/dqSCULAZNPXoKy9IGwEitVQsA7dDJmosqzRZf8WhMwf1Tr46KIwVMzDCHGv
         XypseRgM0m0j+8HuuHYb684rrjVU7jP3tl0mtrJChRzCNGwquPqTWIb0YQIBAwKB
         gQCcUN3Pbm5AZs192kClK+fDB7t0ymNuhUCoXGxopiYe49qU+rgNYB9dU+cMBiyA
         QzflFch+FZ1YXI41yrSTXbvEhcYQy7jdFVJiqNH4Cu767ETzLMFDiDXIv5/h72iN
         hfeRWTW/KbyZbEtq/HeTjIg7rP3h8Fveh/Fj3EY4bmlqgwJBAPbQFmacHXeO4xcP
         aLhFVX/lDrmL7o1TIFNAp8xH/Kqf+L4+uSzoqyvPzO3w2ATdge+VnLhrxzzU48eg
         Y3wHpY8CQQDzM6HNza1tQajA8Jwf9mJygEeLw9uFhp8GZ5IfCFMILpv0ZsQASppf
         9GeFj8Jes0tDn9LkJy0rrTEm8Ns24S8PAkEApIq5mb1o+l9CD1+bJYOOVUNfJl1J
         s4zAN4Bv3YVTHGql1CnQyJscx9/d8/XlWJOr9Q5oevKE0ziX2mrs/VpuXwJBAKIi
         a96JHkjWcICgaBVO7ExVhQfX565Zv1maYWoFjLAfEqLvLVWHEZVNmlkKgZR3h4Jq
         jJgaHh0eIMSgkiSWH18CQGsFhFEdBonmeIm1kY1YWjpM4WS0kUlXOC3sCYg8eXFe
         YEEr9pnY+hhDFegEItQd1hAvrqQhpxhX7HhNNxUoPp4=
         -----END RSA PRIVATE KEY-----
         */
        return [[str componentsSeparatedByString:@"-----"] objectAtIndex:2];
    }
    return nil;
}

- (id)init{
    if (self = [super init]) {
        //load RSA if it is exsit
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:OpenSSLRSAKeyDir]) {
            [fm createDirectoryAtPath:OpenSSLRSAKeyDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }return self;
}

+ (id)shareInstance{
    static OpenSSLRSAWrapper *_opensslWrapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _opensslWrapper = [[self alloc] init];
    });
    return _opensslWrapper;
}

+ (BOOL)canImportRSAKeys{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:OpenSSLRSAPublicKeyFile] && [fm fileExistsAtPath:OpenSSLRSAPrivateKeyFile];
}

- (BOOL)generateRSAKeyPairWithKeySize:(NSInteger)keySize {
    if (NULL != _rsa) {
        RSA_free(_rsa);
        _rsa = NULL;
    }
    _rsa = RSA_generate_key(keySize,RSA_F4,NULL,NULL);
    assert(_rsa != NULL);
    
    if (_rsa) {
        return YES;
    }return NO;
}

- (BOOL)exportRSAKeys{
    assert(_rsa != NULL);
    
    if (_rsa != NULL) {
        FILE *filepub,*filepri;
        filepri = fopen([OpenSSLRSAPrivateKeyFile cStringUsingEncoding:NSASCIIStringEncoding],"w");
        filepub = fopen([OpenSSLRSAPublicKeyFile cStringUsingEncoding:NSASCIIStringEncoding],"w");
        
        if (NULL != filepub && NULL != filepri) {
            int retpri = -1;
            int retpub = -1;
            
            RSA *_pribrsa = RSAPrivateKey_dup(_rsa);
            assert(_pribrsa != NULL);
            retpri = PEM_write_RSAPrivateKey(filepri, _pribrsa, NULL, NULL, 512, NULL, NULL);
            RSA_free(_pribrsa);
            
            RSA *_pubrsa = RSAPublicKey_dup(_rsa);
            assert(_pubrsa != NULL);
            retpub = PEM_write_RSAPublicKey(filepub, _pubrsa);
            RSA_free(_pubrsa);
            
            fclose(filepub);
            fclose(filepri);
            
            return (retpri+retpub>1)?YES:NO;
        }
    }return NO;
}

- (BOOL)importRSAKeyWithType:(KeyType)type{
    FILE *file;
    
    if (type == KeyTypePublic) {
        file = fopen([OpenSSLRSAPublicKeyFile cStringUsingEncoding:NSASCIIStringEncoding],"rb");
    }else{
        file = fopen([OpenSSLRSAPrivateKeyFile cStringUsingEncoding:NSASCIIStringEncoding],"rb");
    }
    
    if (NULL != file) {
        
        if (type == KeyTypePublic) {
            _rsa = PEM_read_RSAPublicKey(file,NULL, NULL, NULL);
            assert(_rsa != NULL);
            // PEM_write_RSAPublicKey(stdout, _rsa);
        }else{
            _rsa = PEM_read_RSAPrivateKey(file, NULL, NULL, NULL);
            assert(_rsa != NULL);
            PEM_write_RSAPrivateKey(stdout, _rsa, NULL, NULL, 0, NULL, NULL);
        }
        
        fclose(file);
        return (_rsa != NULL)?YES:NO;
    } return NO;
}

- (NSData*)encryptRSAKeyWithType:(KeyType)keyType paddingType:(RSA_PADDING_TYPE)padding data:(NSData*)d{
    if (d && [d length]) {
        int flen = [d length];
        unsigned char from[flen];
        bzero(from, sizeof(from));
        memcpy(from, [d bytes], [d length]);
        
        unsigned char to[128];
        bzero(to, sizeof(to));
        
        [self encryptRSAKeyWithType:keyType :from :flen :to :padding];
        
        return [NSData dataWithBytes:to length:sizeof(to)];
    }
    return nil;
}

- (NSData*)encryptRSAKeyWithType:(KeyType)keyType paddingType:(RSA_PADDING_TYPE)padding plainText:(NSString*)text usingEncoding:(NSStringEncoding)encode{
    if (text && [text length]) {
        return [self encryptRSAKeyWithType:keyType paddingType:padding data:[text dataUsingEncoding:encode]];
    }return nil;
}

- (NSString*)decryptRSAKeyWithType:(KeyType)keyType paddingType:(RSA_PADDING_TYPE)padding plainTextData:(NSData*)data usingEncoding:(NSStringEncoding)encode{
    if (data && [data length]) {
        NSData *decryptData = [self decryptRSAKeyWithType:keyType paddingType:padding encryptedData:data];
        return [[NSString alloc] initWithData:decryptData encoding:encode];
    }return nil;
}

- (NSData*)decryptRSAKeyWithType:(KeyType)keyType paddingType:(RSA_PADDING_TYPE)padding encryptedData:(NSData*)data{
    if (data && [data length]) {
        
        int flen = [data length];
        unsigned char from[flen];
        bzero(from, sizeof(from));
        memcpy(from, [data bytes], [data length]);
        
        unsigned char to[128];
        bzero(to, sizeof(to));
        
        [self decryptRSAKeyWithType:keyType :from :flen :to :padding];
        
        return [NSData dataWithBytes:to length:sizeof(to)];
    }
    return nil;
}

- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type{
    
    int len = RSA_size(_rsa);
    
    if (padding_type == RSA_PADDING_TYPE_PKCS1 || padding_type == RSA_PADDING_TYPE_SSLV23) {
        len -= 11;
    }
    
    return len;
}

#pragma mark - Base

- (int)encryptRSAKeyWithType:(KeyType)keyType :(const unsigned char *)from :(int)flen :(unsigned char *)to :(RSA_PADDING_TYPE)padding{
    if (from != NULL && to != NULL) {
        int status = RSA_check_key(_rsa);
        if (!status) {
            NSLog(@"status code %i",status);
            return -1;
        }
        
        switch (keyType) {
            case KeyTypePrivate:{
                //start encrypt
                status =  RSA_private_encrypt(flen, from,to, _rsa,  padding);
            }
                break;
                
            default:{
                //start encrypt
                status =  RSA_public_encrypt(flen,from,to, _rsa,  padding);
            }
                break;
        }
        
        return status;
    }return -1;
}

- (int)decryptRSAKeyWithType:(KeyType)keyType :(const unsigned char *)from :(int)flen :(unsigned char *)to :(RSA_PADDING_TYPE)padding{
    if (from != NULL && to != NULL) {
        int status = RSA_check_key(_rsa);
        if (!status) {
            NSLog(@"status code %i",status);
            return -1;
        }
        
        switch (keyType) {
            case KeyTypePrivate:{
                //start encrypt
                status =  RSA_private_decrypt(flen, from,to, _rsa,  padding);
            }
                break;
                
            default:{
                //start encrypt
                status =  RSA_public_decrypt(flen,from,to, _rsa,  padding);
            }
                break;
        }
        
        return status;
    }return -1;
}

@end