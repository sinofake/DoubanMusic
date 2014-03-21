//
//  TagsViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-15.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagsViewController : UIViewController
@property (nonatomic,retain) NSArray *tagsArray;
@property (nonatomic,assign) id delegate;

@end
