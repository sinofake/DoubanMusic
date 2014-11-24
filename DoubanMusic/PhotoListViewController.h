
#import <UIKit/UIKit.h>
#import "AlbumItem.h"

@interface PhotoListViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *photoScrollView;
    BOOL isLoading;
}
@property (nonatomic,retain) AlbumItem *albumItem;
@property (nonatomic,retain) NSArray *dataArray;

@end
