
#import "LikeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LikeViewController ()

@end

@implementation LikeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我喜欢的音乐人";
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *aView = [[touches anyObject] view];
    if (aView == self.registerLabel) {
        RegisterViewController *rvc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        [self.navigationController pushViewController:rvc animated:YES];
        [rvc release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.registerLabel.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
    LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:lvc animated:YES completion:^{

    }];
    [lvc release];
}
- (void)dealloc {
    [_registerLabel release];
    [super dealloc];
}
@end
