
#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *emailLabel;
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)registerClick:(id)sender;



@end
