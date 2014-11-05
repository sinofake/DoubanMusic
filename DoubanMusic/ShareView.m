//
//  ShareView.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-24.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "ShareView.h"
#import "AppDelegate.h"

@implementation ShareView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)douBanClick:(id)sender {
    [self cancelClick:nil];
    [ShareApp showDouBanShareView];
}

- (IBAction)sinaClick:(id)sender {
    
    [self cancelClick:nil];
    [ShareApp showSinaShareView];
}

- (IBAction)tencentClick:(id)sender {
    [self cancelClick:nil];
    [ShareApp showTencentShareView];
}

- (IBAction)weiXinClick:(id)sender {
    [self cancelClick:nil];
}

- (IBAction)cancelClick:(id)sender {
    [self.delegate dismissWithClickedButtonIndex:0 animated:YES];
}

@end










