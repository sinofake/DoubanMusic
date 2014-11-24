
#import "PhotoBrowserViewController.h"
#import "PhotoItem.h"
#import "UIImageView+WebCache.h"

@interface PhotoBrowserViewController ()

@end

@implementation PhotoBrowserViewController
@synthesize photoArray = _photoArray;
@synthesize currIndex = _currIndex;

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
    // Do any additional setup after loading the view from its nib.
    
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.delegate = self;
    [self.photoScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self loadPicture];
    if (self.currIndex < self.photoArray.count) {
        PhotoItem *item = [self.photoArray objectAtIndex:self.currIndex];
        [self.photoScrollView setContentOffset:CGPointMake(self.currIndex*320, 0)];
        self.descriptionLabel.text = item.desc;
        self.timeLabel.text = [NSString stringWithFormat:@"%@ 上传于 %@",item.uploader_name,item.upload_time];
    }
}

- (void)loadPicture
{
    int i = 0;
    for (PhotoItem *item in self.photoArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*320+10, 10, 300, 280)];
        [imageView setImageWithURL:[NSURL URLWithString:item.url]];
        [self.photoScrollView addSubview:imageView];
        i++;
    }
    self.photoScrollView.contentSize = CGSizeMake(i*320, 280);
}

- (void)loadLabelText
{
    int i = self.photoScrollView.contentOffset.x/320;
    PhotoItem *item = [self.photoArray objectAtIndex:i];
    self.descriptionLabel.text = item.desc;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 上传于 %@",item.uploader_name,item.upload_time];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadLabelText];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self loadLabelText];
        //如果滚动视图处于滚动减速时，用手定住视图使其停止会调用此方法
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.photoArray = nil;
    [_photoScrollView release];
    [_descriptionLabel release];
    [_timeLabel release];
    [super dealloc];
}
@end











