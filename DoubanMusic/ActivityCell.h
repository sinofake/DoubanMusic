
#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *contentImageView;
@property (retain, nonatomic) IBOutlet UILabel *dayLabel;
@property (retain, nonatomic) IBOutlet UILabel *monthLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@end
