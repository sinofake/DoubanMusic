
#import "ActivityWebViewController.h"

@interface ActivityWebViewController ()

@end

@implementation ActivityWebViewController
@synthesize link = _link;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    [activityWebView loadRequest:request];
    activityWebView.delegate = self;
    activityWebView.scalesPageToFit = YES;
    
    av = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
    av.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityWebView addSubview:av];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [av startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [av stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [av stopAnimating];
    //NSLog(@"NSError:%@",[error localizedDescription]);
    if (0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"网页加载失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OKay", nil];
        [alertView show];
        [alertView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [av release];
    self.link = nil;
    [activityWebView release];
    [super dealloc];
}
- (IBAction)doneClick:(id)sender {
    [self.delegate dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)backClick:(id)sender {
    if (activityWebView.canGoBack) {
        [activityWebView goBack];
    }
}

- (IBAction)forwardClick:(id)sender {
    if (activityWebView.canGoForward) {
        [activityWebView goForward];
    }
}
@end
