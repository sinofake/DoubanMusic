//
//  AlbumItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-13.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "AlbumItem.h"

@implementation AlbumItem
@synthesize cover = _cover,aID = _aID,title = _title;

- (void)dealloc
{
    self.cover = nil;
    self.aID = nil;
    self.title = nil;
    [super dealloc];
}

@end
