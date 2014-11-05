//
//  CustomButton.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-10.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)hiddenCurrentLabel;
- (void)showCurrentLabel;

@end
