#import "PlaylistItem.h"

@implementation PlaylistItem
@synthesize uid = _uid;
@synthesize title = _title;

- (void)dealloc
{
    self.uid = nil;
    self.title = nil;
    [super dealloc];
}

@end
