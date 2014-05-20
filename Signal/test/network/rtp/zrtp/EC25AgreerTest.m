#import <SenTestingKit/SenTestingKit.h>
#import "TestUtil.h"
#import "EC25KeyAgreementParticipant.h"
#import "EC25KeyAgreementProtocol.h"

@interface EC25AgreerTest : SenTestCase{
    
    
}
@end

@implementation EC25AgreerTest


-(void) testKeyExchange {
    
    EC25KeyAgreementProtocol* protocol = [EC25KeyAgreementProtocol protocol];
    
    id<KeyAgreementParticipant> ec1 = [protocol generateParticipantWithNewKeys];
    id<KeyAgreementParticipant> ec2 = [protocol generateParticipantWithNewKeys];
    id<KeyAgreementParticipant> ec3 = [protocol generateParticipantWithNewKeys];
    
    NSData* pub_1 = [ec1 getPublicKeyData];
    NSData* pub_2 = [ec2 getPublicKeyData];
    
    NSData* shared_1 = [ec1 calculateKeyAgreementAgainstRemotePublicKey:pub_2];
    NSData* shared_2 = [ec2 calculateKeyAgreementAgainstRemotePublicKey:pub_1];
    
    test([shared_1 isEqualToData:shared_2]);
    
    NSData* shared_3 = [ec3 calculateKeyAgreementAgainstRemotePublicKey:pub_1];
    
    test(![shared_3 isEqualToData:shared_1]);
}

@end