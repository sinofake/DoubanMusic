//
//  ShareView.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-24.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property (nonatomic,assign) id delegate;
- (IBAction)douBanClick:(id)sender;
- (IBAction)sinaClick:(id)sender;
- (IBAction)tencentClick:(id)sender;
- (IBAction)weiXinClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end
