//
//  MusicPlayer.h
//  DoubanMusic
//
//  Created by qianfeng1 on 13-5-21.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCMusicEngine.h"
#import "MusicInfoItem.h"

@interface MusicPlayer : NSObject<NCMusicEngineDelegate>
{
    NCMusicEngine *player;
}
@property (nonatomic,retain) MusicInfoItem *currItem;
@property (nonatomic,retain) NSArray *playQueue;
@property (nonatomic,readonly) CGFloat progress;
@property (nonatomic,assign) id delegate;//更新UI的代理

+ (id)shareInstance;
- (void)playAudioWithUrl:(NSString *)url;
- (void)pause;
- (void)resume;
- (void)stop;
- (void)next;//下一首

- (NCMusicEnginePlayState)state;

@end
