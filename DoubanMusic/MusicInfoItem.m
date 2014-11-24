#import "MusicInfoItem.h"

@implementation MusicInfoItem
@synthesize length = _length,name = _name,picture = _picture,src = _src;

- (void)dealloc
{
    self.name = nil;
    self.length = nil;
    self.picture = nil;
    self.src = nil;
    [super dealloc];
}

@end
