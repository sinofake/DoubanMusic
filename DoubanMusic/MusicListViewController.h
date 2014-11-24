#import <UIKit/UIKit.h>
#import "PlaylistItem.h"

@interface MusicListViewController : UITableViewController
{
    NSArray *dataArray;
}
@property (nonatomic,retain) PlaylistItem *plItem;

@end
