//
//  SinaOAuthManager.h
//  WeiboDemo
//
//  Created by DuHaiFeng on 13-6-23.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "OAuthManager.h"

@interface SinaOAuthManager : OAuthManager

- (id) init;

- (NSDictionary *) getCommonParams;
- (NSString *) getOAuthDomain;

- (TokenModel *) readTokenFromStorage;
- (void) writeTokenToStorage:(TokenModel *)tokenModel;

@end
