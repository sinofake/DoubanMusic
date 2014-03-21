//
//  PhotoItem.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-13.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem
@synthesize desc = _desc,order = _order,photo_id = _photo_id,upload_time = _upload_time,uploader_name = _uploader_name,url = _url;

- (void)dealloc
{
    self.desc = nil;
    self.order = nil;
    self.photo_id = nil;
    self.upload_time = nil;
    self.uploader_name = nil;
    self.url = nil;
    [super dealloc];
}

@end
