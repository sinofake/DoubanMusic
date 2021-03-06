

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "WeiboApiAccount.h"
@class SinaOAuthManager;
@class TencentOAuthManager;

@interface Sina_shareController : UIViewController<ASIHTTPRequestDelegate>
{
    ASIFormDataRequest *formRequest;
    SinaOAuthManager *sinaOAuthManager;
    TencentOAuthManager *tencentOAuthManager;
    
    UIActivityIndicatorView *actvIV;
    UIImageView *infoView;
    UILabel *infoLabel;
}
@property (nonatomic,assign) WeiboType weiboType;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *headImageView;
@property (retain, nonatomic) IBOutlet UITextView *myTextView;
- (IBAction)cancelClick:(id)sender;
- (IBAction)confirmClick:(id)sender;

@end
