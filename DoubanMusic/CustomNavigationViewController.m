#import "CustomNavigationViewController.h"

@interface CustomNavigationViewController ()

@end

@implementation CustomNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

#define IOS7_OR_LATER  [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);
//    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(popVC_click) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IOS7_OR_LATER)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
        //NSLog(@"currentDevice:%@",[[UIDevice currentDevice] systemVersion]);
    }
#endif
    
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)backItemClick
{
    [self popViewControllerAnimated:YES];
}

- (void)popVC_click
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
