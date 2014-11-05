//
//  MusicListViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistItem.h"

@interface MusicListViewController : UITableViewController
{
    NSArray *dataArray;
}
@property (nonatomic,retain) PlaylistItem *plItem;

@end
