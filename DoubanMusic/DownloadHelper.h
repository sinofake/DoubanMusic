//
//  DownloadHelper.h
//  DownloadManager
//
//  Created by qianfeng1 on 13-5-4.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDownloadDelegate.h"
#import "ASIFormDataRequest.h"

@interface DownloadHelper : NSObject<NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>
{
    NSMutableData *downloadData;
    
    NSURLConnection *httpConnection;
    ASIFormDataRequest *formRequest;
}
@property (nonatomic,readonly)NSMutableData *downloadData;
@property (nonatomic,assign) id<HttpDownloadDelegate>delegate;
@property (nonatomic,assign) NSInteger APIType;
@property (nonatomic,copy) NSString *url;

- (void)startDownload;
- (void)startDownloadByPost:(NSDictionary *)dict;

@end
