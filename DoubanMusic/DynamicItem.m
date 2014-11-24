
#import "DynamicItem.h"

@implementation DynamicItem
@synthesize artist = _artist,artist_img = _artist_img,abstract = _abstract,kind = _kind,url = _url,title = _title,time = _time,widget_id = _widget_id,song_id = _song_id,icon = _icon;

- (void)dealloc
{
    self.artist = nil;
    self.artist_img = nil;
    self.abstract = nil;
    self.kind = nil;
    self.url = nil;
    self.title = nil;
    self.time = nil;
    self.widget_id = nil;
    self.song_id = nil;
    self.icon = nil;
    [super dealloc];
}

- (CGFloat)abstractHeight
{
    CGSize size = [self.abstract sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(245, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}

@end
