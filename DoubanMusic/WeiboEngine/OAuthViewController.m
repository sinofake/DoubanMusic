

#import "OAuthViewController.h"
#import "TokenModel.h"
@implementation OAuthController
@synthesize delegate = _delegate;
@synthesize weiboType = _weiboType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.title = @"登录微博";
    
    _webView = [[UIWebView alloc] initWithFrame:[self.view bounds]];
    [_webView setDelegate:self];
    
    weiboManager = [[WeiboManager alloc] initWithDelegate:self];
    NSURL *url = nil;
    if (_weiboType == SINA_WEIBO)
        url = [weiboManager getSinaOAuthCodeUrl];
        else if (_weiboType == TENCENT_WEIBO) {
            url = [weiboManager getTencentOAuthCodeUrl];
        }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    [request release];
    
    [self.view addSubview:_webView];
  
    actvIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actvIV.center = self.view.center;
    [self.view addSubview:actvIV];
  
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"navbar_cancel.png"] forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(0, 0, 40, 27.0f)];
    
    [cancelButton addTarget:self action:@selector(cancelWeibo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    [cancelBtn release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) cancelWeibo {
    if ([_delegate respondsToSelector:@selector(oauthControllerDidCancel:)]) {
        [_delegate oauthControllerDidCancel:self];
    }
}

- (NSDictionary *) getValueFromString:(NSString *)params{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *array = [params componentsSeparatedByString:@"&"];
    for (NSString *s in array) {
        NSArray *subArray = [s componentsSeparatedByString:@"="];
        if ([subArray count]==2) {
            [dict setObject:[subArray objectAtIndex:1] forKey:[subArray objectAtIndex:0]];
        }
    }
    return dict;
}

- (void) sinaWeiboDidSucceed:(NSString *)params {
   
    NSDictionary *paramsDict=[self getValueFromString:params];
    
    NSString *token = [paramsDict objectForKey:@"access_token"];
    NSString *oauth2String = [NSString stringWithFormat:@"access_token=%@", token];
    
    // 用户点取消 error_code=21330
    NSString *errorCode = [paramsDict objectForKey:@"error_code"];
    if (errorCode != nil && [errorCode isEqualToString: @"21330"]) {
        [self cancelWeibo];
    }
    
    NSString *refreshToken = [paramsDict objectForKey:@"refresh_token"];
    NSString *expTime = [paramsDict objectForKey:@"expires_in"];
    NSString *uid = [paramsDict objectForKey:@"uid"];
    //NSString *remindIn = [self getValueFromString:q withName:@"remind_in"];
    
    TokenModel *tokenModel = [[TokenModel alloc] init];
    tokenModel.weiboType = SINA_WEIBO;
    tokenModel.refreshToken = refreshToken;
    tokenModel.accessToken = token;
    tokenModel.userID = uid;
    tokenModel.expireTime = expTime;
    tokenModel.extraInfo = oauth2String;
    
    NSLog(@"token model is %@", tokenModel);
    if ([_delegate respondsToSelector:@selector(oauthControllerSaveToken:withTokenModel:)]) {
        [_delegate oauthControllerSaveToken:self withTokenModel:tokenModel];
    }
    
    if (tokenModel.accessToken && tokenModel.accessToken.length > 5) {
        if ([_delegate respondsToSelector:@selector(oauthControllerDidFinished:)]) {
            [_delegate oauthControllerDidFinished:self];
        }
    }
    
    [tokenModel release];    
}

- (void) tencentWeiboDidSucceed:(NSString *)params {
    
    NSDictionary *paramsDict=[self getValueFromString:params];
    
    NSString *code = [paramsDict objectForKey:@"code"];
    NSString *openID = [paramsDict objectForKey:@"openid"];
    NSString *openKey = [paramsDict objectForKey:@"openkey"];
    
    NSString *getToken = [NSString stringWithFormat:
                          @"https://open.t.qq.com/cgi-bin/oauth2/access_token?client_id=%@&client_secret=%@&redirect_uri=%@&grant_type=authorization_code&code=%@",
                          TENCENT_APP_KEY, TENCENT_APP_SECRET, TENCENT_CALLBACK, code];
    NSLog(@"token url is %@", getToken);
    NSURL *getTokenURL = [NSURL URLWithString:getToken];
    NSString *tokenString = [NSString stringWithContentsOfURL:getTokenURL encoding:NSUTF8StringEncoding error:nil];
    // tokenString is access_token=7f2096d70b49a9ae70f8b7ec1eb93d10&expires_in=604800&refresh_token=0026fe6e66ac7d659dac47dfcac494d6&name=oyangjian001
    NSDictionary *tokenDict=[self getValueFromString:tokenString];
    
    NSString *accessToken = [tokenDict objectForKey:@"access_token"];
    NSString *expTime = [tokenDict objectForKey:@"expires_in"];
    NSString *userName = [tokenDict objectForKey:@"name"];
    
    NSString *oauth2String = [NSString stringWithFormat:
                              @"name=%@&oauth_consumer_key=%@&access_token=%@&openid=%@&openkey=%@&oauth_version=2.a",
                              userName, TENCENT_APP_KEY, accessToken, openID, openKey];
    TokenModel *tokenModel = [[TokenModel alloc] init];
    tokenModel.weiboType = TENCENT_WEIBO;
    tokenModel.accessToken = accessToken;
    tokenModel.expireTime = expTime;
    tokenModel.userName = userName;
    tokenModel.openID = openID;
    tokenModel.openKey = openKey;
    tokenModel.extraInfo = oauth2String;
    if ([_delegate respondsToSelector:@selector(oauthControllerSaveToken:withTokenModel:)]) {
        [_delegate oauthControllerSaveToken:self withTokenModel:tokenModel];
    }
    [tokenModel release];
    
    if (tokenModel.accessToken.length > 5) {
        if ([_delegate respondsToSelector:@selector(oauthControllerDidFinished:)]) {
            [_delegate oauthControllerDidFinished:self];
        }
    }
}

//UIWebView协议方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    // 这里是几个重定向，将每个重定向的网址遍历，如果遇到＃号，则重定向到自己申请时候填写的网址，后面会附上access_token的值
    NSURL *url = [request URL];
    NSLog(@"webview's url = %@",url);
    
    if (_weiboType == TENCENT_WEIBO)
    {
        // http://www.1000phone.com/?code=5b22f613ce98511ac6b1c1dccc35a1ee&openid=6E2D92FFD383EF67410284F536F832AA&openkey=1C8E1BF014179E4DB89D949005A72944
        // Tencent weibo
        
        if ([[url absoluteString] rangeOfString:@"code="].length > 0) {
            NSRange range = [[url absoluteString] rangeOfString:@"?"];
            NSString *params = [[url absoluteString] substringFromIndex:range.location+1];
            [self tencentWeiboDidSucceed:params];
            return NO;
        }
    } else if (_weiboType == SINA_WEIBO) {
        //https://open.t.qq.com/cgi-bin/oauth2/access_token?client_id=801124323&client_secret=9d19ed0ae00ef963d73c06e518a34d27&redirect_uri=http%3A%2F%2Fwww.1000phone.com&grant_type=authorization_code&code=2b7ddb8de2e50640de7ebb02e712ed1c
        
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"#"];
        if ([array count]>1 && ![[array objectAtIndex:1] isEqualToString:@""] && ![[array objectAtIndex:1] isEqualToString:@"\n"]) {
            // http://www.1000phone.com/#access_token=2.00d4s_SC6hIGaC3ab9a0af3aaRBAFC&remind_in=86399&expires_in=86399&uid=2102976985
            [self sinaWeiboDidSucceed:[array objectAtIndex:1]];
            return YES;
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [actvIV startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [actvIV stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [actvIV stopAnimating];
}

- (void) dealloc {
    [weiboManager release];
    [_webView release];
    [actvIV release];
    [_tokenModel release], _tokenModel = nil;
    [super dealloc];
}


@end
