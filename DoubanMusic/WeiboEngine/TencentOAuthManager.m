
#import "TencentOAuthManager.h"

@implementation TencentOAuthManager

- (id) init {
    self = [super initWithOAuthManager:TENCENT_WEIBO];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *) getCommonParams {
    NSDictionary *dict = nil;
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
            _tokenModel.userName, @"name",
            _tokenModel.accessToken, @"access_token",
            _tokenModel.openID, @"openid",
            _tokenModel.openKey, @"openkey",
            TENCENT_APP_KEY, @"oauth_consumer_key",
            @"2.a", @"oauth_version",
            @"221.223.249.130", @"clientip",
            nil];
    return dict;
}

- (NSString *) getOAuthDomain {
    return TENCENT_V2_DOMAIN;
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_EXPIRATION_DATE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_USER_NAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_OPENID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_OPENKEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: TENCENT_USER_STORE_OAUTH2];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) writeTokenToStorage:(TokenModel *)tokenModel {
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.accessToken
                                              forKey:TENCENT_USER_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.expireTime
                                              forKey:TENCENT_USER_STORE_EXPIRATION_DATE];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.userName
                                              forKey:TENCENT_USER_STORE_USER_NAME];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.userID
                                              forKey:TENCENT_USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.openID
                                              forKey:TENCENT_USER_STORE_OPENID];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.openKey
                                              forKey:TENCENT_USER_STORE_OPENKEY];
    [[NSUserDefaults standardUserDefaults] setObject:tokenModel.extraInfo
                                              forKey:TENCENT_USER_STORE_OAUTH2];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (TokenModel *) readTokenFromStorage {
    TokenModel *tokenModel = [[[TokenModel alloc] init] autorelease];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    tokenModel.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_ACCESS_TOKEN];
    tokenModel.expireTime = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_EXPIRATION_DATE];
    tokenModel.userName = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_USER_NAME];
    tokenModel.userID = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_USER_ID];
    tokenModel.openID = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_OPENID];
    tokenModel.openKey = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_OPENKEY];
    tokenModel.extraInfo = [[NSUserDefaults standardUserDefaults] objectForKey:TENCENT_USER_STORE_OAUTH2];
    if (tokenModel.accessToken == nil || [tokenModel.accessToken isEqualToString:@""])
        return nil;
    return tokenModel;
}

@end
