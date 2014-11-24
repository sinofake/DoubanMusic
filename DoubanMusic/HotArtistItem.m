#import "HotArtistItem.h"

@implementation HotArtistItem
@synthesize added = _added,follower = _follower,uid = _uid,member = _member,name = _name,picture = _picture,rank = _rank,style = _style,type = _type,playlistArray = _playlistArray;

- (void)dealloc
{
    self.playlistArray = nil;
    self.added = nil;
    self.follower = nil;
    self.uid = nil;
    self.member = nil;
    self.name = nil;
    self.picture = nil;
    self.rank = nil;
    self.style = nil;
    self.type = nil;
    [super dealloc];
}

@end
