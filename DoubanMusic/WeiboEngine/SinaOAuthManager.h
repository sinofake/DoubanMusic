
#import "OAuthManager.h"

@interface SinaOAuthManager : OAuthManager

- (id) init;

- (NSDictionary *) getCommonParams;
- (NSString *) getOAuthDomain;

- (TokenModel *) readTokenFromStorage;
- (void) writeTokenToStorage:(TokenModel *)tokenModel;

@end
