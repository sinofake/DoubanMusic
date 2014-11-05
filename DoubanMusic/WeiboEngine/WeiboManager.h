//
//  WeiboManager.h
//  WeiboDemo
//
//  Created by DuHaiFeng on 13-6-23.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "WeiboApiAccount.h"

@protocol WeiboHTTPDelegate;
@interface WeiboManager : NSObject <ASIHTTPRequestDelegate>
{
    id <WeiboHTTPDelegate> delegate;
    NSString *authToken;//
}
@property (nonatomic, assign) id <WeiboHTTPDelegate> delegate;
@property (nonatomic, retain) NSString *authToken;

- (id)initWithDelegate:(id)theDelegate;
- (NSURL*)getSinaOAuthCodeUrl;
- (NSURL*)getTencentOAuthCodeUrl;

@end

@protocol WeiboHTTPDelegate <NSObject>

@end
