//
//  DownloadManager.h
//  DownloadManager
//
//  Created by qianfeng1 on 13-10-5.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadHelper.h"
#import "AppDelegate.h"

@interface DownloadManager : NSObject<HttpDownloadDelegate>
{
    NSMutableDictionary *downloadQueue;
    NSMutableDictionary *resultDict;
}
@property (nonatomic,readonly)NSMutableDictionary *resultDict;

+ (id)sharedManager;
- (DownloadHelper *)downloadHelperForUrl:(NSString *)url;

- (void)addDownloadToQueue:(NSString *)url APIType:(NSInteger)type;
- (void)addDownloadToQueue:(NSString *)url APIType:(NSInteger)type dict:(NSDictionary *)dict;

@end
