//
//  HotArtistViewController.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-10.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "HotArtistViewController.h"
#import "DownloadManager.h"
#import "HotArtistItem.h"
#import "HotArtistCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "LoginViewController.h"

@interface HotArtistViewController ()

@end

@implementation HotArtistViewController

- (void)dealloc
{
    self.urlDict = nil;
    [dataArray release];
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

- (void)viewWillAppear:(BOOL)animated
{
    if (isExistLoadMoreButton) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
    }
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSArray alloc] init];
    currPage = 1;
    total_page = 100;
}

- (void)startDownload
{
    DownloadManager *dm = [DownloadManager sharedManager];
    [dm addDownloadToQueue:Hot_Artist_Url APIType:Hot_Artist_Type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:Hot_Artist_Url object:nil];
}

- (void)downlaodPage:(NSInteger)page
{
    isLoading = YES;
    isExistLoadMoreButton = YES;
    DownloadManager *dm = [DownloadManager sharedManager];
    NSString *myTitle = [self.urlDict objectForKey:@"title"];
    self.title = myTitle;
    
    NSString *category = [self.urlDict objectForKey:@"category"];
    NSString *subCategory = [self.urlDict objectForKey:@"subCategory"];
    NSString *subCategoryValue = [self.urlDict objectForKey:@"subCategoryValue"];
    NSString *type = [self.urlDict objectForKey:@"type"];
    NSString *url = [NSString stringWithFormat:@"http://music.douban.com/api/artist/%@?%@=%@&type=%@&sortby=hot&page=%d",category,subCategory,subCategoryValue,type,page];
    url  = [url stringByAppendingString:@"&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"];
    [dm addDownloadToQueue:url APIType:Hot_Artist_Type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:url object:nil];
}

- (void)downloadFinish:(NSNotification *)notification
{
    isLoading = NO;
    DownloadManager *dm = [DownloadManager sharedManager];
    NSDictionary *dict = [dm.resultDict objectForKey:notification.object];
    NSInteger totalPage = [[dict objectForKey:@"total_page"] integerValue];
    if (totalPage > 0) {
        total_page = totalPage;
    }
    NSArray *array = [dict objectForKey:@"artists"];
    if (array == nil) {
        isLoading = YES;
    }
    dataArray = [[[dataArray autorelease] arrayByAddingObjectsFromArray:array] retain];
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
    
    if (isExistLoadMoreButton) {
        return dataArray.count+1;
    }
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *loadMoreCell = @"loadMoreCell";

    if (indexPath.row == dataArray.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadMoreCell];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:loadMoreCell] autorelease];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            label.center = cell.center;
            label.text = @"加载更多...";
            [cell.contentView addSubview:label];
            [label release];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    } else {
        HotArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotArtistCell" owner:self options:nil] lastObject];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        HotArtistItem *item = [dataArray objectAtIndex:indexPath.row];
        [cell.imageView setImageWithURL:[NSURL URLWithString:item.picture]];
        cell.nameLabel.text = item.name;
        cell.styleLabel.text = item.style;
        cell.followerLabel.text = [NSString stringWithFormat:@"%@人关注",item.follower];
        
        CGRect frame = CGRectZero;
        UIImage *img = [UIImage imageNamed:@"like"];
        frame.size = img.size;
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        [button setImage:img forState:UIControlStateNormal];
        [button addTarget:self action:@selector(accessoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 300+indexPath.row;
        cell.accessoryView = button;
        [button release];
        
        return cell;
    }
}

- (void)accessoryButtonClick:(UIButton *)sender
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self presentViewController:lvc animated:YES completion:^{

    }];
    [lvc release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == dataArray.count) {
        return 44.0f;
    }
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
    if (indexPath.row == dataArray.count && !isLoading) {
        currPage++;
        if (currPage >= total_page) {
            currPage = total_page;
        }
        [self downlaodPage:currPage];
    }
    if (indexPath.row < dataArray.count) {
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        HotArtistItem *item = [dataArray objectAtIndex:indexPath.row];
        detailViewController.artist_id = item.uid;
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
     
    
}

@end
