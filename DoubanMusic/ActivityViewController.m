
#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "DownloadManager.h"
#import "ActivityItem.h"
#import "UIImageView+WebCache.h"
#import "ActivityWebViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController
@synthesize artist_id = _artist_id;

- (void)dealloc
{
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
    NSString *url = [NSString stringWithFormat:@"http://music.douban.com/api/artist/artist_event?id=%@",self.artist_id];
    url = [url stringByAppendingString:@"&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"];
    [dm addDownloadToQueue:url APIType:Activity_Type];
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
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil] lastObject];
        cell.timeLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        CGRect frame = CGRectMake(0, 0, 0, 0);
//        UIImage *image = [UIImage imageNamed:@"link"];
//        frame.size = image.size;
//        UIButton *button = [[UIButton alloc] initWithFrame:frame];
//        [button setImage:image forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(accessoryClick:) forControlEvents:UIControlEventTouchUpInside];
//        cell.accessoryView = button;
//        [button release];
    }
    ActivityItem *item = [dataArray objectAtIndex:indexPath.row];
    cell.dayLabel.text = [NSString stringWithFormat:@"%@",item.day];
    cell.monthLabel.text = [NSString stringWithFormat:@"%@月",item.month];
    cell.titleLabel.text = item.title;
    cell.timeLabel.text = item.abstract;
    [cell.contentImageView setImageWithURL:[NSURL URLWithString:item.icon]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
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
  
     ActivityWebViewController *webVC = [[ActivityWebViewController alloc] initWithNibName:@"ActivityWebViewController" bundle:nil];
    ActivityItem *item = [dataArray objectAtIndex:indexPath.row];
    webVC.link = item.url;
     [self presentViewController:webVC animated:YES completion:^{
         webVC.delegate = self;
     }];
     [webVC release];
    
}

@end
