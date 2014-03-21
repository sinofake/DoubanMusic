//
//  DynamicViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicViewController : UITableViewController
{
    NSArray *dataArray;
}

@property (nonatomic,copy) NSString *artist_id;

@end
