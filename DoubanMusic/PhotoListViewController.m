
#import "PhotoListViewController.h"
#import "DownloadManager.h"
#import "PhotoItem.h"
#import "UIButton+WebCache.h"
#import "PhotoBrowserViewController.h"

@interface PhotoListViewController ()

@end

@implementation PhotoListViewController
@synthesize albumItem = _albumItem;

static int count;

- (void)dealloc
{
    count = 0;
    self.albumItem = nil;
    [photoScrollView release];
    [self.dataArray release];
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
    self.title = self.albumItem.title;
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.size.height -= 20+44+49;
    photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
    photoScrollView.backgroundColor = [UIColor lightGrayColor];
    photoScrollView.delegate = self;
    [self.view addSubview:photoScrollView];

    self.dataArray = [NSArray array];
    [self loadPicture];
}

- (void)loadPicture
{
    isLoading = YES;
    DownloadManager *dm = [DownloadManager sharedManager];
    NSString *url = [NSString stringWithFormat:@"http://music.douban.com/api/artist/photos?id=%@&cate=albumcover&limit=15&start=%d",self.albumItem.aID,self.dataArray.count];
    url = [url stringByAppendingString:@"&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"];
    [dm addDownloadToQueue:url APIType:Photo_Type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:url object:nil];
}

- (void)downloadFinish:(NSNotification *)notification
{
    isLoading = NO;
    DownloadManager *dm = [DownloadManager sharedManager];
    NSArray *retArray = [dm.resultDict objectForKey:notification.object];
    if (retArray.count == 0) {
        isLoading = YES;//此时用isLoading来表示全部加载完成，从而不能再加载
        count = 0;
        [self refreshScrollView];//最后做一次总的加载，以妨某些图片加载不成功
        return;
    }
    self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:retArray];
    [self refreshScrollView];
}

- (void)refreshScrollView
{
    for (; count < self.dataArray.count; count++) {
        CGRect frame = CGRectMake(count%3*107.5, count/3*107.5, 105, 105);
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        PhotoItem *item = [self.dataArray objectAtIndex:count];
        [button setImageWithURL:[NSURL URLWithString:item.url]];
        button.tag = 200+count;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [photoScrollView addSubview:button];
    }
    int row = self.dataArray.count%3==0 ? self.dataArray.count/3 : self.dataArray.count/3+1;
    photoScrollView.contentSize = CGSizeMake(320, row*107.5);
}

- (void)buttonClick:(UIButton *)sender
{
    PhotoBrowserViewController *pbVC = [[PhotoBrowserViewController alloc] initWithNibName:@"PhotoBrowserViewController" bundle:nil];
    pbVC.photoArray = self.dataArray;
    pbVC.currIndex = sender.tag - 200;
    [self.navigationController pushViewController:pbVC animated:YES];
    [pbVC release];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat condition = scrollView.contentSize.height-scrollView.contentOffset.y;
    if (condition<scrollView.frame.size.height-15 && !isLoading) {
        [self loadPicture];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end












