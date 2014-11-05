//
//  ActivityWebViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-13.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityWebViewController : UIViewController<UIWebViewDelegate>
{
    
    IBOutlet UIWebView *activityWebView;
    UIActivityIndicatorView *av;
    
}
- (IBAction)doneClick:(id)sender;
- (IBAction)backClick:(id)sender;
- (IBAction)forwardClick:(id)sender;

@property (nonatomic,copy) NSString *link;
@property (nonatomic,assign) id delegate;

@end
