#import "AlbumItem.h"

@implementation AlbumItem
@synthesize cover = _cover,aID = _aID,title = _title;

- (void)dealloc
{
    self.cover = nil;
    self.aID = nil;
    self.title = nil;
    [super dealloc];
}

@end
