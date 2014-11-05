//
//  MusicInfoItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "MusicInfoItem.h"

@implementation MusicInfoItem
@synthesize length = _length,name = _name,picture = _picture,src = _src;

- (void)dealloc
{
    self.name = nil;
    self.length = nil;
    self.picture = nil;
    self.src = nil;
    [super dealloc];
}

@end
