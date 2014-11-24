
#import "LeaveMsgViewController.h"
#import "DownloadManager.h" 
#import "LeaveMsgItem.h"
#import "UIImageView+WebCache.h"

@interface LeaveMsgViewController ()

@end

@implementation LeaveMsgViewController
@synthesize artist_id = _artist_id;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [dataArray release];
    [inputView release];
    self.artist_id = nil;
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

- (void)createInputTextView
{
    UIImage *image = [UIImage imageNamed:@"input2"];
    CGRect frame = CGRectMake(20, 10, 0, 0);
    frame.size = image.size;
    inputView = [[UITextView alloc] initWithFrame:frame];
    [inputView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    inputView.autocorrectionType = UITextAutocorrectionTypeYes;
    inputView.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    inputView.delegate = self;
    
    //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:sendButton,btnSpace, doneButton, nil];
    [sendButton release];
    [btnSpace release];
    [doneButton release];
    [topView setItems:buttonsArray];
    [inputView setInputAccessoryView:topView];
    [topView release];
}

//关闭键盘
-(void) dismissKeyBoard{
    [inputView resignFirstResponder];
}

- (void)sendMessage{
    [inputView resignFirstResponder];
    NSLog(@"send Message");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self createInputTextView];
    DownloadManager *dm = [DownloadManager sharedManager];
    NSString *url = [NSString stringWithFormat:@"http://music.douban.com/api/artist/artist_board?id=%@",self.artist_id];;
    url  = [url stringByAppendingString:@"&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"];
    [dm addDownloadToQueue:url APIType:LeaveMsg_Type];
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
    return dataArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *inputCellID = @"inputCell";
    NSString *cellFlag = indexPath.row ? CellIdentifier : inputCellID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            [cell.contentView addSubview:inputView];
        }
    }
    if (indexPath.row) {
        LeaveMsgItem *item = [dataArray objectAtIndex:indexPath.row-1];
        [cell.imageView setImageWithURL:[NSURL URLWithString:item.icon]];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@",item.author,item.content];
    }   
    return cell;
}

- (CGFloat)heightOfContent:(NSString *)content
{
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.imageView.image == nil && indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:@"icon"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100.0f;
    }
    LeaveMsgItem *item = [dataArray objectAtIndex:indexPath.row-1];
    CGFloat height = [self heightOfContent:[NSString stringWithFormat:@"%@: %@",item.author,item.content]];
    if (height > 44.0f) {
        return height+10;
    }
    return 44.0f;
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
