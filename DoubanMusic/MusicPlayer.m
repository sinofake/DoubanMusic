

#import "MusicPlayer.h"
#import "MusicPlayerView.h" 
#import "UIImageView+WebCache.h"

@implementation MusicPlayer
@synthesize progress = _progress;
@synthesize playQueue = _playQueue;
@synthesize delegate = _delegate;
@synthesize currItem = _currItem;

+(id)shareInstance
{
    static id _s;
    if (!_s) {
        _s = [[[self class] alloc] init];
    }
    return _s;
}

- (id)init
{
    self = [super init];
    if (self) {
        player = [[NCMusicEngine alloc] init];
        player.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.currItem = nil;
    [player release];
    self.playQueue = nil;
    [super dealloc];
}

- (void)playAudioWithUrl:(NSString *)url
{
    [player playUrl:[NSURL URLWithString:url]];
    for (MusicInfoItem *item in self.playQueue) {
        if (item.src == url) {
            self.currItem = item;
            break;
        }
    }
    MusicPlayerView *mpv = (MusicPlayerView *)self.delegate;
    [mpv.headImageView setImageWithURL:[NSURL URLWithString:self.currItem.picture]];
    mpv.titleLabel.text = self.currItem.name;
    mpv.timeLabel.text = self.currItem.length;
}

- (void)next
{
    for (MusicInfoItem *item in self.playQueue) {
        if (item.src == self.currItem.src) {
            NSInteger index = [self.playQueue indexOfObject:self.currItem];
            index++;
            if (index == self.playQueue.count) {
                index = 0;
            }
            self.currItem = [self.playQueue objectAtIndex:index];
            [self playAudioWithUrl:self.currItem.src];
            break;
        }
    }
}

- (void)pause
{
    [player pause];
}

- (void)resume
{
    [player resume];
}

- (void)stop
{
    [player stop];
}

- (void)engine:(NCMusicEngine *)engine playProgress:(CGFloat)progress
{
    MusicPlayerView *mpv = (MusicPlayerView *)self.delegate;
    [mpv.progressBar setProgress:progress];
    CGFloat time = [self.currItem.length floatValue]*(1-progress);
    mpv.timeLabel.text = [NSString stringWithFormat:@"%.2f",time];
    
    CGRect frame = mpv.titleLabel.frame;
    frame.origin.x -= 2.0;
    if (frame.origin.x+mpv.titleLabel.text.length*13.0/3 < 60.0f) {
        frame.origin.x = 130.0f;
    }
    mpv.titleLabel.frame = frame;
    [mpv sendSubviewToBack:mpv.titleLabel];
}

- (NCMusicEnginePlayState)state
{
    return player.playState;
}

@end











