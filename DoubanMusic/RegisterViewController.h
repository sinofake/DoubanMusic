//
//  RegisterViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-22.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *emailLabel;
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)registerClick:(id)sender;



@end
