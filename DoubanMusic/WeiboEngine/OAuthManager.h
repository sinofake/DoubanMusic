
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "WeiboManager.h"

#import "OAuthViewController.h"
#import "TokenModel.h"


@protocol OAuthControllerDelegate;
@class OAuthController;

@interface OAuthManager : NSObject
<OAuthControllerDelegate>
{
    WeiboType _weiboType;
    
    TokenModel *_tokenModel;
    
    UINavigationController *_navController;
    OAuthController *_oauthController;
}
@property (nonatomic, retain) TokenModel *tokenModel;

- (id) initWithOAuthManager:(WeiboType)weiboType;

- (void) logout;
- (void) login;
- (BOOL) isAlreadyLogin;
- (void) addPrivatePostParamsForASI:(ASIFormDataRequest *)request;

/* 子类必须要重写该方法 abstract method */
- (NSDictionary *) getCommonParams;
- (NSString *) getOAuthDomain;

- (TokenModel *) readTokenFromStorage;
- (void) writeTokenToStorage:(TokenModel *)tokenModel;

@end