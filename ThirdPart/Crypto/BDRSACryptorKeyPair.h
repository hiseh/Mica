//
//  Created by Patrick Hogan on 10/12/12.
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface BDRSACryptorKeyPair : NSObject

@property (nonatomic, strong) NSString *publicKey;
@property (nonatomic, strong) NSString *privateKey;
@property (nonatomic, strong) NSString *exportPublicKey;
@property (nonatomic, strong) NSString *remotePublicKey;

- (id)initWithPublicKey:(NSString *)publicKey
        remotePublicKey:(NSString *)remotePublicKey
        exportPublicKey:(NSString *)exportPublicKey
             privateKey:(NSString *)privateKey;

@end
