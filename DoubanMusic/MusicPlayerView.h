//
//  MusicPlayerView.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-22.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerView : UIView

@property (retain, nonatomic) IBOutlet UIImageView *headImageView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIProgressView *progressBar;
@property (retain, nonatomic) IBOutlet UIButton *playOrPauseButton;

- (IBAction)playOrPauseClick:(id)sender;
- (IBAction)nextClick:(id)sender;
- (IBAction)shareClick:(id)sender;

@end
