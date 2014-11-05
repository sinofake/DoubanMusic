//
//  PlaylistItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "PlaylistItem.h"

@implementation PlaylistItem
@synthesize uid = _uid;
@synthesize title = _title;

- (void)dealloc
{
    self.uid = nil;
    self.title = nil;
    [super dealloc];
}

@end
