
#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property (nonatomic,assign) id delegate;
- (IBAction)douBanClick:(id)sender;
- (IBAction)sinaClick:(id)sender;
- (IBAction)tencentClick:(id)sender;
- (IBAction)weiXinClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end
