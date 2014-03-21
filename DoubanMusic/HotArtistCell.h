//
//  HotArtistCell.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-11.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotArtistCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *headImageView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *styleLabel;
@property (retain, nonatomic) IBOutlet UILabel *followerLabel;

@end
