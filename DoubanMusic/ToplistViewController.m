//
//  ToplistViewController.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-7.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "ToplistViewController.h"
#import "DownloadManager.h"
#import "HotSongItem.h"
#import "UIImageView+WebCache.h"
#import "CustomButton.h"
#import "HotArtistViewController.h"
#import "DetailViewController.h"
#import "MusicPlayer.h"
#import "MusicInfoItem.h"

@interface ToplistViewController ()

@end

@implementation ToplistViewController

- (void)dealloc
{
    [haVC release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [dataArray release];
    [myTableView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"豆瓣音乐人";
        
    }
    return self;
}

- (void)createOptionView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor grayColor];
    NSArray *array = [NSArray arrayWithObjects:@"热门单曲",@"热门音乐人", nil];
    for (NSString *str in array) {
        static int i;
        CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(30+i*140, 0, 120, 30) title:str];
        button.tag = 250+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button release];
        if (i == 0) {
            [button showCurrentLabel];
        }
        i++;
    }
    [self.view addSubview:view];
    [view release];
}

- (void)buttonClick:(CustomButton *)sender
{
    [sender showCurrentLabel];
    if (sender.tag == 250) {
        CustomButton *csButton = (CustomButton *)[self.view viewWithTag:251];
        [csButton hiddenCurrentLabel];
        if (haVC && haVC.view.superview) {
            [haVC willMoveToParentViewController:nil];
            [haVC removeFromParentViewController];
            [haVC.view removeFromSuperview];
        }
    } else if (sender.tag == 251) {
        CustomButton *csButton = (CustomButton *)[self.view viewWithTag:250];
        [csButton hiddenCurrentLabel];
        if (!haVC) {
             haVC = [[HotArtistViewController alloc] init];
            [haVC startDownload];
        }
        if (haVC.view.superview == nil) {
            [self addChildViewController:haVC];
            haVC.view.frame = myTableView.frame;
            [self.view addSubview:haVC.view];
            [haVC didMoveToParentViewController:self];
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.y += 30;
    frame.size.height -= 20+44+30+49;
    myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    [self createOptionView];
    
    DownloadManager *dm = [DownloadManager sharedManager];
    [dm addDownloadToQueue:Hot_Song_Url APIType:Hot_Song_Type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:Hot_Song_Url object:nil];

}

- (void)downloadFinish:(NSNotification *)notification
{
    DownloadManager *dm = [DownloadManager sharedManager];
    dataArray = [[dm.resultDict objectForKey:notification.object] retain];
    [myTableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CGRect frame = CGRectMake(0, 0, 0, 0);
    UIImage *image = [UIImage imageNamed:@"play"];
    frame.size = image.size;
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(accessoryAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexPath.row + 200;
    cell.accessoryView = button;
    [button release];
    
    HotSongItem *item = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.artist;
    [cell.imageView setImageWithURL:[NSURL URLWithString:item.picture]];
    
    return cell;
}

- (void)accessoryAction:(UIButton *)sender
{
    HotSongItem *item = [dataArray objectAtIndex:sender.tag-200];
    MusicPlayer *mp = [MusicPlayer shareInstance];
    NSMutableArray *array = [NSMutableArray array];
    for (HotSongItem *item in dataArray) {
        MusicInfoItem *musicItem = [[MusicInfoItem alloc] init];
        musicItem.length = item.length;
        musicItem.name = item.name;
        musicItem.src = item.src;
        musicItem.picture = item.picture;
        [array addObject:musicItem];
    }
    mp.playQueue = array;
    [mp playAudioWithUrl:item.src];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.imageView.image == nil) {
        cell.imageView.image = [UIImage imageNamed:@"icon"];
    }
    if (cell.imageView.subviews.count == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        label.textColor = [UIColor colorWithRed:240.0/255 green:248.0/255 blue:1 alpha:1];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:40];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%.2d",indexPath.row+1];
        [cell.imageView addSubview:label];
        label.tag = 100;
        [label release];
    } else {
        UILabel *label = (UILabel *)[cell.imageView viewWithTag:100];
        label.text = [NSString stringWithFormat:@"%.2d",indexPath.row+1];
    }
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
    
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    HotSongItem *item = [dataArray objectAtIndex:indexPath.row];
    detailViewController.artist_id = item.artist_id;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
    
}

@end
