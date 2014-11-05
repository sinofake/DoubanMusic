//
//  HotArtistCell.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-11.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "HotArtistCell.h"

@implementation HotArtistCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headImageView release];
    [_nameLabel release];
    [_styleLabel release];
    [_followerLabel release];
    [super dealloc];
}
@end
