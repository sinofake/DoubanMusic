//
//  LeaveMsgItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-14.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "LeaveMsgItem.h"

@implementation LeaveMsgItem
@synthesize author = _author,content = _content,icon = _icon,time = _time;

- (void)dealloc
{
    self.author = nil;
    self.content = nil;
    self.icon = nil;
    self.time = nil;
    [super dealloc];
}

@end
