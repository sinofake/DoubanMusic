//
//  ActivityCell.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

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
    [_contentImageView release];
    [_dayLabel release];
    [_monthLabel release];
    [_titleLabel release];
    [_timeLabel release];
    [super dealloc];
}
@end
