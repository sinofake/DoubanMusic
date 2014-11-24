
#import <UIKit/UIKit.h>

@interface HotArtistViewController : UITableViewController
{
    NSArray *dataArray;
    BOOL isExistLoadMoreButton;
    BOOL isLoading;
    NSInteger currPage;
    NSInteger total_page;
}
@property (nonatomic,retain) NSDictionary *urlDict;
- (void)startDownload;
- (void)downlaodPage:(NSInteger)page;

@end
