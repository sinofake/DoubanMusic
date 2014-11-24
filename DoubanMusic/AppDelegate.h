#import <UIKit/UIKit.h>

#define ShareApp (AppDelegate *)[[UIApplication sharedApplication] delegate]
@class SinaOAuthManager;
@class TencentOAuthManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaOAuthManager *sinaOAuthManager;
    TencentOAuthManager *tencentOAuthManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSData *imgData;

- (void)showLoadingView;
- (void)hiddenLoadingView;
- (void)addSubView:(UIView *)aView;

//分享相关
- (void)showDouBanShareView;
- (void)showSinaShareView;
- (void)showTencentShareView;

@end
