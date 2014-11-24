#import "CustomTabBarViewController.h"
#import "ToplistViewController.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "CustomNavigationViewController.h"
#import "MusicPlayerView.h"
#import "MusicPlayer.h"

@interface CustomTabBarViewController ()
{
    NSTimer *timer;
    UILabel *musicInfoLabel;
    MusicPlayerView *musicPlayerView;
}

@end

@implementation CustomTabBarViewController

static int timerFlag;

- (void)dealloc
{
    [musicPlayerView release];
    [musicInfoLabel release];
    timerFlag = 0;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tabBar.hidden = YES;
    [self createViewController];
    [self createCustomViewControllers];
    
    [self createMusicInfoLabel];
    [self createMusicPlayerView];
}

- (void)createViewController
{
    NSArray *imgArray = [NSArray arrayWithObjects:@"toplist",@"search",@"like", nil];
    NSArray *vcArray = [NSArray arrayWithObjects:@"ToplistViewController",
                      @"SearchViewController",
                      @"LikeViewController", nil];
    NSMutableArray *array = [NSMutableArray array];
    int i = 0;
    for (NSString *str in vcArray) {
        Class class = NSClassFromString(str);
        UIViewController *vc = [[class alloc] init];
        vc.tabBarItem.image = [UIImage imageNamed:[imgArray objectAtIndex:i]];
        CustomNavigationViewController *nac = [[CustomNavigationViewController alloc] initWithRootViewController:vc];
        [array addObject:nac];
        [vc release];
        [nac release];
        i++;
    }
    self.viewControllers = array;
}

- (void)createCustomViewControllers
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]) - 49, CGRectGetWidth([[UIScreen mainScreen] bounds]), 49)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.userInteractionEnabled = YES;
    bgView.tag = 9999;
    [self.view addSubview:bgView];
    [bgView release];
    
    NSArray *imgArray = [NSArray arrayWithObjects:@"toplist",@"search",@"like", nil];
    NSArray *selectedImgArray = [NSArray arrayWithObjects:@"toplist_current",@"search_current",@"like_current", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"热门排行",@"分类浏览",@"我喜欢的", nil];
    CGFloat space = 15.0f;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(space+(space+50)*i,0, 50, 49)];
        [btn setBackgroundImage:[UIImage imageNamed:[imgArray objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[selectedImgArray objectAtIndex:i]] forState:UIControlStateSelected];
        btn.tag = 10000+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,29, 50, 20)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = [titleArray objectAtIndex:i];
        [btn addSubview:label];
        [label release];
        
        if (i == 0) {
            btn.selected = YES;
        }
    }
//    UIImageView *devideLine = [[UIImageView alloc] initWithFrame:CGRectMake(space+(space+50)*3, 0, 20, 49)];
//    devideLine.image = [UIImage imageNamed:@"controls_bg"];
//    [bgView addSubview:devideLine];
//    devideLine.backgroundColor = [UIColor clearColor];
//    [devideLine release];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    [playBtn setFrame:CGRectMake(320-80, 0, 50, 49)];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"playing"] forState:UIControlStateNormal];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"playing_current"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,29, 50, 20)];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"正在播放";
    [playBtn addSubview:label];
    [label release];
    [bgView addSubview:playBtn];
}

- (void)btnClick:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 10000;
    UIImageView *bgView = (UIImageView *)[self.view viewWithTag:9999];
    int i = 0;
    for (UIView *aView in bgView.subviews) {
        if (i >= 3) {
            break;
        }
        if ([aView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)aView;
            if (btn.tag == sender.tag) {
                btn.selected = YES;
            } else {
                btn.selected = NO;
            }
        }
        i++;
    }
}

- (void)createMusicInfoLabel
{
    musicInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]),320, 60)];
    musicInfoLabel.text = @"当前没有正在播放的歌曲";
    musicInfoLabel.textColor = [UIColor whiteColor];
    musicInfoLabel.font = [UIFont systemFontOfSize:14];
    musicInfoLabel.textAlignment = NSTextAlignmentCenter;
    musicInfoLabel.backgroundColor = [UIColor blackColor];
//    musicInfoLabel.alpha = 0.85;
    UIImageView *bgView = (UIImageView *)[self.view viewWithTag:9999];
    [self.view insertSubview:musicInfoLabel belowSubview:bgView];
}

- (void)createMusicPlayerView
{
    musicPlayerView = [[[NSBundle mainBundle] loadNibNamed:@"MusicPlayerView" owner:self options:nil] lastObject];
    musicPlayerView.frame = musicInfoLabel.frame;
//    musicPlayerView.alpha = 0.85;
    UIImageView *bgView = (UIImageView *)[self.view viewWithTag:9999];
    [self.view insertSubview:musicPlayerView belowSubview:bgView];
    
    MusicPlayer *musicPlayer = [MusicPlayer shareInstance];
    musicPlayer.delegate = musicPlayerView;
    //设置代理，更新UI
}

- (void)playBtnClick:(UIButton *)sender
{
    if (timerFlag%2 == 0) {
        [self showMusicLabel];
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(hiddenMusicLabel) userInfo:nil repeats:YES];
        timerFlag++;
    } else {
        [self hiddenMusicLabel];
    }
}

- (void)showMusicLabel
{
    MusicPlayer *musicPlayer = [MusicPlayer shareInstance];

    if ([musicPlayer state] == NCMusicEnginePlayStatePaused || [musicPlayer state] == NCMusicEnginePlayStatePlaying) {
        [UIView animateWithDuration:0.6f animations:^{
            CGRect frame = musicPlayerView.frame;
            frame.origin.y = CGRectGetHeight([[UIScreen mainScreen] bounds])-64-40;
            musicPlayerView.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:0.6f animations:^{
            CGRect frame = musicInfoLabel.frame;
            frame.origin.y = CGRectGetHeight([[UIScreen mainScreen] bounds])-64-40;
            musicInfoLabel.frame = frame;
        }];
    }
    
}

- (void)hiddenMusicLabel
{
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = musicPlayerView.frame;
        frame.origin.y = CGRectGetHeight([[UIScreen mainScreen] bounds]);
        musicPlayerView.frame = frame;
    }];
    
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = musicInfoLabel.frame;
        frame.origin.y = CGRectGetHeight([[UIScreen mainScreen] bounds]);
        musicInfoLabel.frame = frame;
    }];
    if (timerFlag%2) {
        timerFlag += 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end












