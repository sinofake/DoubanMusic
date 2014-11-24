

#import <UIKit/UIKit.h>

#import "WeiboManager.h"


@protocol OAuthControllerDelegate;
@class TokenModel;
@interface OAuthController : UIViewController
<UIWebViewDelegate>
{
    TokenModel *_tokenModel;
    
    UIWebView *_webView;
    UIActivityIndicatorView *actvIV;
    WeiboManager *weiboManager;
    
    id <OAuthControllerDelegate> _delegate;
    
    WeiboType _weiboType;
}
@property (nonatomic, assign) WeiboType weiboType;
@property (nonatomic, assign) id <OAuthControllerDelegate> delegate;

@end

@protocol OAuthControllerDelegate <NSObject>

- (void) oauthControllerDidFinished:(OAuthController *)oauthController;
- (void) oauthControllerDidCancel:(OAuthController *)oauthController;
- (void) oauthControllerSaveToken:(OAuthController *)oauthController withTokenModel:(TokenModel *)tokenModel;

@end
