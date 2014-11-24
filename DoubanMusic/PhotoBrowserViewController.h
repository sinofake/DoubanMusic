
#import <UIKit/UIKit.h>

@interface PhotoBrowserViewController : UIViewController<UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,retain) NSArray *photoArray;
@property (nonatomic,assign) int currIndex;

@end
