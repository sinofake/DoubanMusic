//
//  RegisterViewController.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-22.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.nameField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *labelArray = [NSArray arrayWithObjects:self.emailLabel,self.nameLabel,self.passwordLabel, nil];
    NSArray *fieldArray = [NSArray arrayWithObjects:self.emailField,self.nameField,self.passwordField, nil];
    
    int i = 0;
    for (UITextField *tf in fieldArray) {
        tf.leftView = [labelArray objectAtIndex:i];
        tf.leftViewMode = UITextFieldViewModeAlways;
        i++;
    }
    self.title = @"注册";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_emailLabel release];
    [_emailField release];
    [_nameLabel release];
    [_nameField release];
    [_passwordLabel release];
    [_passwordField release];
    [super dealloc];
}
- (IBAction)registerClick:(id)sender {
}
@end
