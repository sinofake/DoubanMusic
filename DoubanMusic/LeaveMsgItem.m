
#import "LeaveMsgItem.h"

@implementation LeaveMsgItem
@synthesize author = _author,content = _content,icon = _icon,time = _time;

- (void)dealloc
{
    self.author = nil;
    self.content = nil;
    self.icon = nil;
    self.time = nil;
    [super dealloc];
}

@end
