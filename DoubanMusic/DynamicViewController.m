
#import "DynamicViewController.h"
#import "DownloadManager.h"
#import "DynamicItem.h"
#import "DynamicCell.h"
#import "UIImageView+WebCache.h"
#import "MusicListViewController.h"
#import "ActivityWebViewController.h"

@interface DynamicViewController ()

@end

@implementation DynamicViewController
@synthesize artist_id = _artist_id;

- (void)dealloc
{
    [dataArray release];
    self.artist_id = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    DownloadManager *dm = [DownloadManager sharedManager];
    NSString *url = [NSString stringWithFormat:@"http://music.douban.com/api/artist/artist_update?id=%@",self.artist_id];
    url = [url stringByAppendingString:@"&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"];
    [dm addDownloadToQueue:url APIType:Dynamic_Type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:url object:nil];
}

- (void)downloadFinish:(NSNotification *)notification
{
    DownloadManager *dm = [DownloadManager sharedManager];
    dataArray = [[dm.resultDict objectForKey:notification.object] retain];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *cellID = @"DynamicCell";
    DynamicItem *item = [dataArray objectAtIndex:indexPath.row];
    if ([item.kind isEqualToString:@"song"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
            CGRect frame = CGRectMake(0, 0, 0, 0);
            UIImage *image = [UIImage imageNamed:@"play"];
            frame.size = image.size;
            UIButton *button = [[UIButton alloc] initWithFrame:frame];
            [button setImage:image forState:UIControlStateNormal];
            [button addTarget:self action:@selector(accessoryClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = button;
            [button release];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        cell.accessoryView.tag = 200+indexPath.row;
        cell.textLabel.text = [NSString stringWithFormat:@"[单曲]%@",item.title];
        cell.detailTextLabel.text = item.time;
        return cell;
        
    } else {
        DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Dynamic" owner:self options:nil] lastObject];
            cell.titleLabel.font = [UIFont systemFontOfSize:15];
            cell.timeLabel.font = [UIFont systemFontOfSize:11];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        NSString *titleStr;
        if ([item.kind isEqualToString:@"note"]) {
            titleStr = @"日记";
            [cell.headImageView setImageWithURL:[NSURL URLWithString:item.artist_img]];
        } else {
            titleStr = @"活动";
            [cell.headImageView setImageWithURL:[NSURL URLWithString:item.icon]];
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"[%@]%@",titleStr,item.title];
        cell.timeLabel.text = item.time;
        
        cell.abstractLabel.font = [UIFont systemFontOfSize:13];
        cell.abstractLabel.numberOfLines = 0;
        CGRect frame = cell.abstractLabel.frame;
        frame.size.height = item.abstractHeight;
        
        cell.abstractLabel.frame = frame;
        cell.abstractLabel.text = item.abstract;
        
        frame = cell.timeLabel.frame;
        frame.origin.y += 30+item.abstractHeight+5;
        cell.frame = frame;
        
        return cell;
    }
}

- (void)accessoryClick:(UIButton *)sender
{
    NSLog(@"play Music button.tag:%d",sender.tag);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicItem *item = [dataArray objectAtIndex:indexPath.row];
    if ([item.kind isEqualToString:@"song"]) {
        return 55.0f;
    } else {
        return 30+item.abstractHeight+5+20;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    DynamicItem *item = [dataArray objectAtIndex:indexPath.row];
    if ([item.kind isEqualToString:@"song"]) {
        MusicListViewController *mvc = [[MusicListViewController alloc] init];
        PlaylistItem *plItem = [[[PlaylistItem alloc] init] autorelease];
        plItem.title = item.artist;
        plItem.uid = item.widget_id;
        mvc.plItem = plItem;
        //上面这段代码不能用下面这两行来代替，因为这样做的mvc.plItem没有实例化。
//        mvc.plItem.title = item.artist;
//        mvc.plItem.uid = item.widget_id;
        
        [self.navigationController pushViewController:mvc animated:YES];
        [mvc release];
    } else {
        ActivityWebViewController *webVC = [[[ActivityWebViewController alloc] initWithNibName:@"ActivityWebViewController" bundle:nil] autorelease];
        webVC.link = item.url;
        [self presentViewController:webVC animated:YES completion:^{
            webVC.delegate = self;
        }];
    }
}

@end










