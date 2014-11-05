//
//  ActivityItem.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityItem : NSObject
@property (nonatomic,copy) NSString *abstract;
@property (nonatomic,copy) NSString *day;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;

@end
