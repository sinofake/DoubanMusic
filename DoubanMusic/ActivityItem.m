//
//  ActivityItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem
@synthesize abstract = _abstract,day = _day,month = _month,title = _title,icon = _icon,url = _url;

- (void)dealloc
{
    self.abstract = nil;
    self.day = nil;
    self.month = nil;
    self.title = nil;
    self.icon = nil;
    self.url = nil;
    [super dealloc];
}

@end
