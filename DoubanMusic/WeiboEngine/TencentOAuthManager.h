
#import "OAuthManager.h"

@interface TencentOAuthManager : OAuthManager

- (id) init;

- (NSDictionary *) getCommonParams;
- (NSString *) getOAuthDomain;

- (TokenModel *) readTokenFromStorage;
- (void) writeTokenToStorage:(TokenModel *)tokenModel;

@end
