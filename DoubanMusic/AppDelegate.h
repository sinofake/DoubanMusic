//
//  AppDelegate.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-7.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ShareApp (AppDelegate *)[[UIApplication sharedApplication] delegate]
@class SinaOAuthManager;
@class TencentOAuthManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaOAuthManager *sinaOAuthManager;
    TencentOAuthManager *tencentOAuthManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSData *imgData;

- (void)showLoadingView;
- (void)hiddenLoadingView;
- (void)addSubView:(UIView *)aView;

//分享相关
- (void)showDouBanShareView;
- (void)showSinaShareView;
- (void)showTencentShareView;

@end
