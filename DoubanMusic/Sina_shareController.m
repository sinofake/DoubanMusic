
#import "Sina_shareController.h"
#import "SinaOAuthManager.h"
#import "TencentOAuthManager.h"

@interface Sina_shareController ()

@end

@implementation Sina_shareController

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
    sinaOAuthManager = [[SinaOAuthManager alloc] init];
    tencentOAuthManager = [[TencentOAuthManager alloc] init];
    
    self.myTextView.text = @"(分享自@豆瓣音乐人官方微博)\n";
    self.myTextView.backgroundColor = [UIColor lightGrayColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"act_Bg2" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];

    infoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
    infoView.image = image;
    infoView.center = self.view.center;
    
    [self.view addSubview:infoView];
    infoView.hidden = YES;
    
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 150, 40)];
    infoLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:infoLabel];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.text = @"正在分享...";
    
    actvIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [infoView addSubview:actvIV];
    actvIV.center = CGPointMake(75, 30);
    [actvIV startAnimating];
    [infoView bringSubviewToFront:actvIV];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@",[request responseString]);
    
    [actvIV stopAnimating];
    infoLabel.text = @"分享成功";
    [self performSelector:@selector(cancelClick:) withObject:nil afterDelay:2.0f];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [actvIV stopAnimating];
    infoLabel.text = @"分享失败";
    [self performSelector:@selector(cancelClick:) withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [sinaOAuthManager release];
    [tencentOAuthManager release];
    [actvIV release];
    [infoView release];
    [infoLabel release];
    [formRequest cancel];
    [formRequest release];
    [_titleLabel release];
    [_headImageView release];
    [_myTextView release];
    [super dealloc];
}

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)shareSinaWeiBo
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", [sinaOAuthManager getOAuthDomain], @"statuses/upload.json"];
    NSURL *url = [NSURL URLWithString:path];
    formRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    NSLog(@"url:%@",url);
    
    NSData *imgData = UIImageJPEGRepresentation(self.headImageView.image, 0.8);
    if (!imgData) {
        imgData = UIImagePNGRepresentation(self.headImageView.image);
    }
    
    [formRequest addData:imgData withFileName:@"douban.jpg" andContentType:@"image/jpeg" forKey:@"pic"];
    [formRequest setPostValue:self.myTextView.text forKey:@"status"];
    [formRequest setPostValue:@"40.034753" forKey:@"lat"];
    [formRequest setPostValue:@"116.311435" forKey:@"long"];
    [sinaOAuthManager addPrivatePostParamsForASI:formRequest];
    [formRequest setDelegate:self];
    
    infoView.hidden = NO;
    [actvIV startAnimating];
    
    [formRequest startAsynchronous];
    [ASIFormDataRequest setShouldUpdateNetworkActivityIndicator:NO];
}

- (void)shareTencentWeiBo
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", [tencentOAuthManager getOAuthDomain], @"t/add_pic"];
    NSURL *url = [NSURL URLWithString:path];
    formRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSData *imgData = UIImageJPEGRepresentation(self.headImageView.image, 0.8);
    if (!imgData) {
        imgData = UIImagePNGRepresentation(self.headImageView.image);
    }
    
    [formRequest setPostValue:@"json" forKey:@"format"];
    [formRequest setPostValue:self.myTextView.text forKey:@"content"];
    [formRequest addData:imgData withFileName:@"douban.jpg" andContentType:@"image/jpeg" forKey:@"pic"];
    [formRequest setPostValue:@"40.034753" forKey:@"latitude"];
    [formRequest setPostValue:@"116.311435" forKey:@"longitude"];
    [formRequest setPostValue:@"0" forKey:@"syncflag"];
    
    [tencentOAuthManager addPrivatePostParamsForASI:formRequest];
    
    infoView.hidden = NO;
    [actvIV startAnimating];
    
    [formRequest setDelegate:self];
    [formRequest startAsynchronous];
}

- (IBAction)confirmClick:(id)sender {
    if (self.weiboType == SINA_WEIBO) {
        [self shareSinaWeiBo];
    } else if (self.weiboType == TENCENT_WEIBO) {
        [self shareTencentWeiBo];
    }
}
@end










