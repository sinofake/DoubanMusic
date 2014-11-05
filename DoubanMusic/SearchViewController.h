//
//  SearchViewController.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-7.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsViewController.h"

@interface SearchViewController : UITableViewController<UISearchDisplayDelegate>
{
    NSArray *dataArray;
    NSArray *tagArray;
    UISearchBar *mSearchBar;
    UISearchDisplayController *searchDC;
    
    TagsViewController *tagsVC;
}

@end
