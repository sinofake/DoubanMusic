//
//  DynamicItem.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-13.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicItem : NSObject
@property (nonatomic,copy) NSString *artist;
@property (nonatomic,copy) NSString *artist_img;
@property (nonatomic,copy) NSString *kind;
@property (nonatomic,copy) NSString *song_id;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *widget_id;
@property (nonatomic,copy) NSString *abstract;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *icon;

- (CGFloat)abstractHeight;

@end
