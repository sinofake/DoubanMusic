
#import "SinaOAuthManager.h"

@implementation SinaOAuthManager

- (id) init {
    self = [super initWithOAuthManager:SINA_WEIBO];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *) getCommonParams {
    NSDictionary *dict = nil;
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            _tokenModel.accessToken, @"access_token",
            nil];
    return dict;
}

- (NSString *) getOAuthDomain {
    return SINA_V2_DOMAIN;
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SINA_USER_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SINA_USER_STORE_EXPIRATION_DATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/* 读写存放的token */
- (void) writeTokenToStorage:(TokenModel *)tokenModel {
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.accessToken
                                              forKey:SINA_USER_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.expireTime
                                              forKey:SINA_USER_STORE_EXPIRATION_DATE];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (TokenModel *) readTokenFromStorage {
    TokenModel *tokenModel = [[[TokenModel alloc] init] autorelease];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    tokenModel.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:SINA_USER_STORE_ACCESS_TOKEN];
    tokenModel.expireTime = [[NSUserDefaults standardUserDefaults] objectForKey:SINA_USER_STORE_EXPIRATION_DATE];
    if (tokenModel.accessToken == nil || [tokenModel.accessToken isEqualToString:@""])
        return nil;
    return tokenModel;
}


@end
