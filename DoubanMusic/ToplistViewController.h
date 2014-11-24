#import <UIKit/UIKit.h>
@class HotArtistViewController;

@interface ToplistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *dataArray;
    
    HotArtistViewController *haVC;
}

@end
