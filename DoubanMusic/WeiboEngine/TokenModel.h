
#import <Foundation/Foundation.h>
#import "WeiboApiAccount.h"
@interface TokenModel : NSObject {
    WeiboType _weiboType;//微博类型
    NSString *_accessToken;
    NSString *_refreshToken;
    
    NSString *_expireTime;
    NSString *_userName;
    NSString *_userID;
    
    NSString *_openID;
    NSString *_openKey;
    
    NSString *_extraInfo;
}
@property (nonatomic, assign) WeiboType weiboType;
@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *refreshToken;

@property (nonatomic, retain) NSString *expireTime;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *openID;
@property (nonatomic, retain) NSString *openKey;
@property (nonatomic, retain) NSString *extraInfo;

@end
