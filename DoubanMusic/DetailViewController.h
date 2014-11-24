
#import <UIKit/UIKit.h>
#import "CustomButton.h"
@class HotArtistItem;

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UIImageView *headImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *styleLabel;
    IBOutlet UILabel *memberLabel;
    IBOutlet UILabel *followerLabel;
    IBOutletCollection(CustomButton) NSArray *buttonArray;

    IBOutlet UIScrollView *upScrollView;
    IBOutlet UITableView *musicTableView;
    
    NSArray *dataArray;
}
- (IBAction)likeClick:(id)sender;
- (IBAction)shareClick:(id)sender;
- (IBAction)musicLibraryClick:(id)sender;
- (IBAction)activityClick:(id)sender;
- (IBAction)albumClick:(id)sender;
- (IBAction)dynamicClick:(id)sender;
- (IBAction)leaveMsgClick:(id)sender;
@property (nonatomic,copy) NSString *artist_id;
@property (nonatomic,retain) HotArtistItem *haItem;


@end








