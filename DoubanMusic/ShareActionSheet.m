//
//  ShareActionSheet.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-24.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "ShareActionSheet.h"
#import "ShareView.h"

@implementation ShareActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        ShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
        shareView.delegate = self;
        [self addSubview:shareView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
