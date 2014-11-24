
#import "SearchItem.h"

@implementation SearchItem
@synthesize gid = _gid;
@synthesize name = _name;

- (void)dealloc
{
    self.gid = nil;
    self.name = nil;
    [super dealloc];
}

@end

@implementation SearchTagItem
@synthesize size = _size;
@synthesize name = _name;
@synthesize url = _url;

- (void)dealloc
{
    self.size = nil;
    self.name = nil;
    self.url = nil;
    [super dealloc];
}

@end














