//
//  PhotoListViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-13.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumItem.h"

@interface PhotoListViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *photoScrollView;
    BOOL isLoading;
}
@property (nonatomic,retain) AlbumItem *albumItem;
@property (nonatomic,retain) NSArray *dataArray;

@end
