//
//  ToplistViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-7.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotArtistViewController;

@interface ToplistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *dataArray;
    
    HotArtistViewController *haVC;
}

@end
