#import "HotSongItem.h"

@implementation HotSongItem
@synthesize count = _count,picture = _picture,name = _name,artist = _artist,rank = _rank,uid = _uid,length = _length,artist_id = _artist_id,src = _src,widget_id = _widget_id;
- (void)dealloc
{
    self.count = nil;
    self.picture = nil;
    self.name = nil;
    self.artist = nil;
    self.rank = nil;
    self.uid = nil;
    self.length = nil;
    self.artist_id = nil;
    self.src = nil;
    self.widget_id = nil;
    [super dealloc];
}

@end
