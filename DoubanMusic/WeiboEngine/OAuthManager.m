
#import "OAuthManager.h"

@class OAuthController;

@implementation OAuthManager
@synthesize tokenModel = _tokenModel;

- (id) initWithOAuthManager:(WeiboType)weiboType {
    self = [super init];
    if (self) {
        _weiboType = weiboType;
        _oauthController = [[OAuthController alloc] init];
        [_oauthController setDelegate:self];
        [_oauthController setWeiboType:weiboType];
        _navController = [[UINavigationController alloc] initWithRootViewController:_oauthController];
        
         [_navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        
        self.tokenModel = [self readTokenFromStorage];
    }
    return self;
}
- (void) logout {
    
}

- (void) showUI {
    UIViewController *wv = _navController;
    
    UIWindow* wnd = [[UIApplication sharedApplication] keyWindow];
    CGRect windowRect = wnd.frame;
    
    CGRect origRect = windowRect;
    origRect.origin.y += windowRect.size.height;
    [wv.view setFrame:origRect];
    
    [wnd addSubview:wv.view];
    
    [UIView animateWithDuration:0.5 animations:^(void){
        [wv.view setFrame:windowRect];
    }];
}
- (void) hiddenUI {
    UIViewController *wv = _navController;
    
    CGRect rect = wv.view.frame;
    CGRect newRect = rect;
    newRect.origin.y += newRect.size.height;
    [UIView animateWithDuration:0.5 animations:^(void){
        wv.view.frame = newRect;
    } completion:^(BOOL finished) {
        [wv.view removeFromSuperview];
    }];
}

- (void) login {
    [self showUI];
}

- (void) oauthControllerDidFinished:(OAuthController *)oauthController {
    [self hiddenUI];
    [[NSNotificationCenter defaultCenter] postNotificationName:OAuthLoginSucceed object:[NSNumber numberWithInt:_weiboType] userInfo:nil];
}
- (void) oauthControllerDidCancel:(OAuthController *)oauthController {
    [self hiddenUI];
}
- (void) oauthControllerSaveToken:(OAuthController *)oauthController withTokenModel:(TokenModel *)tokenModel {
    NSLog(@"token is save token %@ %@", tokenModel, tokenModel.accessToken);
    self.tokenModel = tokenModel;
    [self writeTokenToStorage:tokenModel];
}


- (BOOL) isAlreadyLogin {
    return _tokenModel.accessToken?YES:NO;
}

- (void) addPrivatePostParamsForASI:(ASIFormDataRequest *)request {
    NSDictionary *dict = [self getCommonParams];
    NSArray *keyArray = [dict allKeys];
    NSArray *valueArray = [dict allValues];
    for (int i = 0; i < [keyArray count]; i++) {
        [request setPostValue:[valueArray objectAtIndex:i] forKey:[keyArray objectAtIndex:i]];
    }
}

#pragma mark -
#pragma mark Abstract Method Override Function
- (void) writeTokenToStorage:(TokenModel *)tokenModel {
    NSLog(@"%s %s override me", __FILE__, __func__);
}
- (TokenModel *) readTokenFromStorage {
    NSLog(@"%s %s override me", __FILE__, __func__);
    return nil;
}

- (NSDictionary *) getCommonParams {
    NSLog(@"%s %s override me", __FILE__, __func__);
    /* 子类中实现 */
    return nil;
}

- (NSString *) getOAuthDomain {
    NSLog(@"%s %s override me", __FILE__, __func__);
    /* 子类中实现 */
    return nil;
}

- (void) dealloc {
    [_oauthController release], _oauthController = nil;
    [_navController release], _navController = nil;
    
    self.tokenModel= nil;
    [super dealloc];
}
@end
