//
//  LoginViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-18.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;
- (IBAction)loginClick:(id)sender;
@end
