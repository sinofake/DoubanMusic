//
//  AppDelegate.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-7.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarViewController.h"
#import "LoginViewController.h"
#import "SinaOAuthManager.h"
#import "TencentOAuthManager.h"
#import "Sina_shareController.h"

@implementation AppDelegate
@synthesize imgData = _imgData;

- (void)dealloc
{
    self.imgData = nil;
    [sinaOAuthManager release];
    [tencentOAuthManager release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    CustomTabBarViewController *tbc = [[CustomTabBarViewController alloc] init];
    self.window.rootViewController = tbc;
    [tbc release];
    
    [self addLoadingView];
    
    sinaOAuthManager = [[SinaOAuthManager alloc] init];
    tencentOAuthManager = [[TencentOAuthManager alloc] init];
    [sinaOAuthManager logout];
    [tencentOAuthManager logout];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OAuthSucceed:) name:OAuthLoginSucceed object:nil];
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;    
}

- (void)addSubView:(UIView *)aView
{
    [self.window addSubview:aView];
}

- (void)addLoadingView
{
    CGRect frame = CGRectNull;
    frame.size = [UIImage imageNamed:@"loading.gif"].size;
    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
    UIWebView *wb = [[UIWebView alloc] initWithFrame:frame];
    wb.center = self.window.center;
    [wb loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    wb.tag = 5001;
    wb.userInteractionEnabled = NO;//用户不可交互
    [self.window addSubview:wb];
    [wb release];
    
}

- (void)showLoadingView
{
    UIWebView *wb = (UIWebView *)[self.window viewWithTag:5001];
    wb.hidden = NO;
    NSLog(@"wb:%@", wb);
    [self.window bringSubviewToFront:wb];
}

- (void)hiddenLoadingView
{
    UIWebView *wb = (UIWebView *)[self.window viewWithTag:5001];
    wb.hidden = YES;
}

- (void)OAuthSucceed:(NSNotification *)notification
{
    WeiboType type = [notification.object intValue];
    if (type == SINA_WEIBO) {
        NSLog(@"新浪登录成功");
        
        [self performSelector:@selector(presentSinaView) withObject:nil afterDelay:0.5];
        
    } else if (type == TENCENT_WEIBO) {
         NSLog(@"腾讯登录成功");
        [self performSelector:@selector(presentTencentView) withObject:nil afterDelay:0.5];
    }
}

- (void)showDouBanShareView
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [[[ShareApp window] rootViewController] presentViewController:lvc animated:YES completion:^{
        
    }];
    [lvc release];
}

- (void)presentSinaView
{
    Sina_shareController *ssc = [[Sina_shareController alloc] initWithNibName:@"Sina_shareController" bundle:nil];
    ssc.weiboType = SINA_WEIBO;

    [[[ShareApp window] rootViewController] presentViewController:ssc animated:YES completion:^{
        ssc.titleLabel.text = @"分享新浪微博";
        ssc.headImageView.image = [UIImage imageWithData:self.imgData];
    }];
    [ssc release];
}

- (void)presentTencentView
{
    Sina_shareController *ssc = [[Sina_shareController alloc] initWithNibName:@"Sina_shareController" bundle:nil];
    ssc.weiboType = TENCENT_WEIBO;
    
    [[[ShareApp window] rootViewController] presentViewController:ssc animated:YES completion:^{
        ssc.titleLabel.text = @"分享腾讯微博";
        ssc.headImageView.image = [UIImage imageWithData:self.imgData];
    }];
    [ssc release];
}

- (void)showSinaShareView
{
    if ([sinaOAuthManager isAlreadyLogin] == NO) {
        [sinaOAuthManager login];
    } else {
        [self presentSinaView];
    }
}

- (void)showTencentShareView
{
    if ([tencentOAuthManager isAlreadyLogin] == NO) {
        [tencentOAuthManager login];
    } else {
        [self presentTencentView];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
