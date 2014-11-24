
#import "MusicPlayerView.h"
#import "MusicPlayer.h"
#import "ShareActionSheet.h"
#import "AppDelegate.h"

@implementation MusicPlayerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_headImageView release];
    [_titleLabel release];
    [_timeLabel release];
    [_playOrPauseButton release];
    [_progressBar release];
    [super dealloc];
}

- (IBAction)playOrPauseClick:(id)sender {
    MusicPlayer *musicPlayer = [MusicPlayer shareInstance];
    if (musicPlayer.state == NCMusicEnginePlayStatePlaying) {
        [musicPlayer pause];
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    } else if (musicPlayer.state == NCMusicEnginePlayStatePaused) {
        [musicPlayer resume];
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    }
}

- (IBAction)nextClick:(id)sender {
    [[MusicPlayer shareInstance] next];
}

- (IBAction)shareClick:(id)sender {
    AppDelegate *appDelegate = ShareApp;
    
    //将要分享的图片数据传过去
    NSData *imgData = UIImagePNGRepresentation(self.headImageView.image);
    if (!imgData) {
        imgData = UIImageJPEGRepresentation(self.headImageView.image, 0.8f);
    }
    appDelegate.imgData = imgData;
    
    ShareActionSheet *sas = [[ShareActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [sas showInView:self];
    [sas release];
}
@end
