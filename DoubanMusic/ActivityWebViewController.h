
#import <UIKit/UIKit.h>

@interface ActivityWebViewController : UIViewController<UIWebViewDelegate>
{
    
    IBOutlet UIWebView *activityWebView;
    UIActivityIndicatorView *av;
    
}
- (IBAction)doneClick:(id)sender;
- (IBAction)backClick:(id)sender;
- (IBAction)forwardClick:(id)sender;

@property (nonatomic,copy) NSString *link;
@property (nonatomic,assign) id delegate;

@end
