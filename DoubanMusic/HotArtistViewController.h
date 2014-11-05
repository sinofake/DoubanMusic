//
//  HotArtistViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-10.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotArtistViewController : UITableViewController
{
    NSArray *dataArray;
    BOOL isExistLoadMoreButton;
    BOOL isLoading;
    NSInteger currPage;
    NSInteger total_page;
}
@property (nonatomic,retain) NSDictionary *urlDict;
- (void)startDownload;
- (void)downlaodPage:(NSInteger)page;

@end
