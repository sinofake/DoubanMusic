
#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;
- (IBAction)loginClick:(id)sender;
@end
