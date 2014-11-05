//
//  HttpDownloadDelegate.h
//  DownloadManager
//
//  Created by qianfeng1 on 13-5-4.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DownloadHelper;

@protocol HttpDownloadDelegate <NSObject>
- (void)downloadCompleted:(DownloadHelper *)dh;

@optional
- (void)downloadError:(DownloadHelper *)dh;

@end
