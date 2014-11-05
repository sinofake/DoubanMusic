//
//  LeaveMsgViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-12.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveMsgViewController : UITableViewController
{
    NSArray *dataArray;
    UITextView *inputView;

}
@property (nonatomic,copy) NSString *artist_id;

@end
