//
//  SearchItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-15.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "SearchItem.h"

@implementation SearchItem
@synthesize gid = _gid;
@synthesize name = _name;

- (void)dealloc
{
    self.gid = nil;
    self.name = nil;
    [super dealloc];
}

@end

@implementation SearchTagItem
@synthesize size = _size;
@synthesize name = _name;
@synthesize url = _url;

- (void)dealloc
{
    self.size = nil;
    self.name = nil;
    self.url = nil;
    [super dealloc];
}

@end














