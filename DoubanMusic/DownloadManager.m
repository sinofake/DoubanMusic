#import "DownloadManager.h"
#import "NSObject+SBJson.h"
#import "HotSongItem.h"
#import "HotArtistItem.h"
#import "PlaylistItem.h"
#import "MusicInfoItem.h"
#import "ActivityItem.h"
#import "AlbumItem.h"
#import "PhotoItem.h"
#import "DynamicItem.h"
#import "LeaveMsgItem.h"
#import "SearchItem.h"

@implementation DownloadManager
@synthesize resultDict;

- (void)dealloc
{
    [downloadQueue release];
    [resultDict release];
    [super dealloc];
}

+ (id)sharedManager
{
    static id _s;
    if (_s == nil) {
        _s = [[[self class] alloc] init];
    }
    return _s;
}

- (id)init
{
    self = [super init];
    if (self) {
        downloadQueue = [[NSMutableDictionary alloc] init];
        resultDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (DownloadHelper *)downloadHelperForUrl:(NSString *)url
{
    DownloadHelper *dh = [downloadQueue objectForKey:url];
    return [[dh retain] autorelease];
}

- (void)addDownloadToQueue:(NSString *)url APIType:(NSInteger)type
{
    DownloadHelper *dh = [[DownloadHelper alloc] init];
    dh.url = url;
    dh.APIType = type;
    dh.delegate = self;
    [dh startDownload];
    [downloadQueue setObject:dh forKey:url];
    [dh release];
    [ShareApp showLoadingView];
}

- (void)addDownloadToQueue:(NSString *)url APIType:(NSInteger)type dict:(NSDictionary *)dict
{
    DownloadHelper *dh = [[DownloadHelper alloc] init];
    dh.url = url;
    dh.APIType = type;
    dh.delegate = self;
    [dh startDownloadByPost:dict];
    [downloadQueue setObject:dh forKey:url];
    [dh release];
    [ShareApp showLoadingView];
}

- (void)downloadCompleted:(DownloadHelper *)dh
{
    switch (dh.APIType) {
        case Hot_Song_Type:
            [self parseHotSong:dh];
            break;
        case Hot_Artist_Type:
            [self parseHotArtist:dh];
            break;
        case Detail_Type:
            [self parseDetail:dh];
            break;
        case Music_List_Type:
            [self parseMusicList:dh];
            break;
        case Activity_Type:
            [self parseActivity:dh];
            break;
        case Album_Type:
            [self parseAlbum:dh];
            break;
        case Photo_Type:
            [self parsePhoto:dh];
            break;
        case Dynamic_Type:
            [self parseDynamic:dh];
            break;
        case LeaveMsg_Type:
            [self parseLeaveMsg:dh];
            break;
        case Search_Type:
            [self parseSearch:dh];
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:dh.url object:dh.url];
    [ShareApp hiddenLoadingView];
}

- (void)downloadError:(DownloadHelper *)dh
{
    [ShareApp hiddenLoadingView];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:@"下载失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OKay", nil];
    [av show];
    [av release];
}

- (id)handleDownloadData:(NSData *)data
{
    NSString *ret = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSMutableString *mutableStr = [NSMutableString stringWithString:ret];
    NSRange range = [mutableStr rangeOfString:@"$.setp(0.5083166616968811)("];
    if (range.location != NSNotFound) {
        [mutableStr deleteCharactersInRange:range];
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length-2, 2)];
    }
    NSDictionary *jsonDict = [mutableStr JSONValue];
//    NSLog(@"jsonDict:%@",jsonDict);
    
    return [[jsonDict retain] autorelease];
}

- (void)parseHotSong:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    if (jsonDict) {
        NSArray *array = [jsonDict objectForKey:@"songs"];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *subDict in array) {
            HotSongItem *item = [[[HotSongItem alloc] init] autorelease];
            item.count = [subDict objectForKey:@"count"];
            item.picture = [subDict objectForKey:@"picture"];
            item.name = [subDict objectForKey:@"name"];
            item.artist = [subDict objectForKey:@"artist"];
            item.rank = [subDict objectForKey:@"rank"];
            item.uid = [subDict objectForKey:@"id"];
            item.length = [subDict objectForKey:@"length"];
            item.artist_id = [subDict objectForKey:@"artist_id"];
            item.src = [subDict objectForKey:@"src"];
            item.widget_id = [subDict objectForKey:@"widget_id"];
            [mutableArray addObject:item];
        }
        [resultDict setObject:mutableArray forKey:Hot_Song_Url];
    }
}

- (void)parseHotArtist:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    NSString *total_page = [jsonDict objectForKey:@"total_page"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (total_page) {
        [dict setObject:total_page forKey:@"total_page"];
    }
    
    NSArray *jsonArray = [jsonDict objectForKey:@"artists"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in jsonArray) {
        HotArtistItem *item = [[HotArtistItem alloc] init];
        item.added = [dict objectForKey:@"added"];
        item.follower = [dict objectForKey:@"follower"];
        item.uid = [dict objectForKey:@"id"];
        item.member = [dict objectForKey:@"member"];
        item.name = [dict objectForKey:@"name"];
        item.picture = [dict objectForKey:@"picture"];
        item.rank = [dict objectForKey:@"rank"];
        item.style = [dict objectForKey:@"style"];
        item.type = [dict objectForKey:@"type"];
        [array addObject:item];
        [item release];
    }
    [dict setObject:array forKey:@"artists"];
    
    [resultDict setObject:dict forKey:dh.url];
}

- (void)parseDetail:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    HotArtistItem *item = [[[HotArtistItem alloc] init] autorelease];
    item.added = [jsonDict objectForKey:@"added"];
    item.follower = [jsonDict objectForKey:@"follower"];
    item.uid = [jsonDict objectForKey:@"id"];
    item.member = [jsonDict objectForKey:@"member"];
    item.name = [jsonDict objectForKey:@"name"];
    item.picture = [jsonDict objectForKey:@"picture"];
    item.style = [jsonDict objectForKey:@"style"];
    item.type = [jsonDict objectForKey:@"type"];
    
    NSArray *playlistArray = [jsonDict objectForKey:@"playlist"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in playlistArray) {
        PlaylistItem *playItem = [[PlaylistItem alloc] init];
        playItem.uid = [dict objectForKey:@"id"];
        playItem.title = [dict objectForKey:@"title"];
        [array addObject:playItem];
        [playItem release];
    }
    item.playlistArray = array;
    [resultDict setObject:item forKey:dh.url];
}

- (void)parseMusicList:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    NSArray *array = [jsonDict objectForKey:@"songs"];
    NSMutableArray *musicArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        MusicInfoItem *item = [[MusicInfoItem alloc] init];
        item.length = [dict objectForKey:@"length"];
        item.name = [dict objectForKey:@"name"];
        item.picture = [dict objectForKey:@"picture"];
        item.src = [dict objectForKey:@"src"];
        [musicArray addObject:item];
        [item release];
    }
    [resultDict setObject:musicArray forKey:dh.url];
}

- (NSString *)handleAbstract:(NSString *)abstract
{
    NSMutableString *str = [NSMutableString stringWithString:abstract];
    NSRange range = [str rangeOfString:@"日"];
    if (range.location != NSNotFound) {
        range = NSMakeRange(0, range.location+range.length);
        [str deleteCharactersInRange:range];
    }
    return str;
}

- (void)parseActivity:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    NSArray *array = [jsonDict objectForKey:@"events"];
    NSMutableArray *eventArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        ActivityItem *item = [[ActivityItem alloc] init];
        item.abstract = [dict objectForKey:@"abstract"];
        item.abstract = [self handleAbstract:item.abstract];
        item.day = [dict objectForKey:@"day"];
        item.month = [dict objectForKey:@"month"];
        item.title = [dict objectForKey:@"title"];
        item.icon = [dict objectForKey:@"icon"];
        item.url = [dict objectForKey:@"url"];
        [eventArray addObject:item];
        [item release];
    }
    [resultDict setObject:eventArray forKey:dh.url];
}

- (void)parseAlbum:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    NSArray *array = [jsonDict objectForKey:@"albums"];
    NSMutableArray *albumArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        AlbumItem *item = [[AlbumItem alloc] init];
        item.cover = [dict objectForKey:@"cover"];
        item.aID = [dict objectForKey:@"id"];
        item.title = [dict objectForKey:@"title"];
        [albumArray addObject:item];
        [item release];
    }
    [resultDict setObject:albumArray forKey:dh.url];
}

- (void)parsePhoto:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    NSArray *array = [jsonDict objectForKey:@"photos"];
    NSMutableArray *photoArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        PhotoItem *item = [[PhotoItem alloc] init];
        item.desc = [dict objectForKey:@"desc"];
        item.order = [dict objectForKey:@"order"];
        item.photo_id = [dict objectForKey:@"photo_id"];
        item.upload_time = [dict objectForKey:@"upload_time"];
        item.uploader_name = [dict objectForKey:@"uploader_name"];
        item.url = [dict objectForKey:@"url"];
        [photoArray addObject:item];
        [item release];
    }
    [resultDict setObject:photoArray forKey:dh.url];
}

- (void)parseDynamic:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    //NSLog(@"jsonDict:%@",jsonDict);
    NSArray *array = [jsonDict objectForKey:@"updates"];
    NSMutableArray *dynamicArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        DynamicItem *item = [[DynamicItem alloc] init];
        item.artist = [dict objectForKey:@"artist"];
        item.artist_img = [dict objectForKey:@"artist_img"];
        item.kind = [dict objectForKey:@"kind"];
        item.song_id = [dict objectForKey:@"song_id"];
        item.time = [dict objectForKey:@"time"];
        item.title = [dict objectForKey:@"title"];
        item.widget_id = [dict objectForKey:@"widget_id"];
        item.abstract = [dict objectForKey:@"abstract"];
        item.url = [dict objectForKey:@"url"];
        item.icon = [dict objectForKey:@"icon"];
        [dynamicArray addObject:item];
        [item release];
    }
    [resultDict setObject:dynamicArray forKey:dh.url];
}

- (void)parseLeaveMsg:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
    NSArray *array = [jsonDict objectForKey:@"messages"];
    NSMutableArray *msgArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        LeaveMsgItem *item = [[LeaveMsgItem alloc] init];
        item.author = [dict objectForKey:@"author"];
        item.content = [dict objectForKey:@"content"];
        item.icon = [dict objectForKey:@"icon"];
        item.time = [dict objectForKey:@"time"];
        [msgArray addObject:item];
        [item release];
    }
    [resultDict setObject:msgArray forKey:dh.url];
}

- (void)parseSearch:(DownloadHelper *)dh
{
    NSDictionary *jsonDict = [self handleDownloadData:dh.downloadData];
//    NSLog(@"jsonDict:%@",jsonDict);
    NSArray *jsonArray = [jsonDict objectForKey:@"genrelist"];
    NSMutableArray *categoryArray = [NSMutableArray array];
    NSMutableDictionary *retDict = [NSMutableDictionary dictionary];
    for (NSArray *array in jsonArray) {
        SearchItem *item = [[SearchItem alloc] init];
        item.gid = [array objectAtIndex:0];
        item.name = [array objectAtIndex:1];
        [categoryArray addObject:item];
        [item release];
    }
    [retDict setObject:categoryArray forKey:@"genrelist"];
    
    NSMutableArray *tagArray = [NSMutableArray array];
    NSArray *jsonArray2 = [jsonDict objectForKey:@"tags"];
    for (NSDictionary *dict in jsonArray2) {
        SearchTagItem *item = [[SearchTagItem alloc] init];
        item.name = [dict objectForKey:@"name"];
        item.size = [dict objectForKey:@"size"];
        item.url = [dict objectForKey:@"url"];
        [tagArray addObject:item];
        [item release];
    }
    [retDict setObject:tagArray forKey:@"tags"];
    
    [resultDict setObject:retDict forKey:dh.url];
}

@end













