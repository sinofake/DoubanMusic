//
//  SearchItem.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-15.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchItem : NSObject
@property (nonatomic,copy) NSString *gid;
@property (nonatomic,copy) NSString *name;

@end

@interface SearchTagItem : NSObject
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *size;

@end
