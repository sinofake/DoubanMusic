#import <Foundation/Foundation.h>

@interface HotArtistItem : NSObject
@property (nonatomic,copy) NSString *added;
@property (nonatomic,copy) NSString *follower;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *member;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *rank;
@property (nonatomic,copy) NSString *style;
@property (nonatomic,copy) NSString *type;

@property (nonatomic,retain) NSArray *playlistArray;
@end
