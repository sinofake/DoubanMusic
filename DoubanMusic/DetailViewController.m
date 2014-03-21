//
//  DetailViewController.m
//  DoubanMusic
//
//  Created by qianfeng1 on 13-10-11.
//  Copyright (c) 2013年 qianfeng1. All rights reserved.
//

#import "DetailViewController.h"
#import "DownloadManager.h"
#import "HotArtistItem.h"
#import "PlaylistItem.h"
#import "UIImageView+WebCache.h"
#import "MusicListViewController.h"
#import "ActivityViewController.h"
#import "AlbumViewController.h"
#import "DynamicViewController.h"
#import "LeaveMsgViewController.h"
#import "LoginViewController.h"
#import "ShareActionSheet.h"
#import "AppDelegate.h"

@interface DetailViewController ()
{
    ActivityViewController *activeVC;
    AlbumViewController *albumVC;
    DynamicViewController *dynamicVC;
    LeaveMsgViewController *leaveMsgVC; 
}

@end

@implementation DetailViewController
@synthesize haItem = _haItem;
@synthesize artist_id = _artist_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
    }
    return self;
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    musicTableView.delegate = self;
    musicTableView.dataSource = self;
    musicTableView.tableHeaderView = upScrollView;
    
    
    for (CustomButton *button in buttonArray) {
        if (button.frame.origin.x < 5) {
            [button showCurrentLabel];
        }
    }

    
    DownloadManager *dm = [DownloadManager sharedManager];
    NSString *url = [NSString stringWithFormat:@"http://music.douban.com/api/artist/artist_playlist?id=%@",self.artist_id];
    url = [url stringByAppendingString:@"&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"];
    [dm addDownloadToQueue:url APIType:Detail_Type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:url object:nil];
    //初始化各视图并赋值，不然后面的判断会用到下面视图的view从而导致先去调用viewDidLoad,造成赋值失败;
    activeVC = [[ActivityViewController alloc] init];
    albumVC = [[AlbumViewController alloc] init];
    dynamicVC = [[DynamicViewController alloc] init];
    leaveMsgVC = [[LeaveMsgViewController alloc] init];
    activeVC.artist_id = self.artist_id;
    albumVC.artist_id = self.artist_id;
    dynamicVC.artist_id = self.artist_id;
    leaveMsgVC.artist_id = self.artist_id;
}

- (void)loadContents
{
    self.title = self.haItem.name;
    [headImageView setImageWithURL:[NSURL URLWithString:self.haItem.picture]];
    nameLabel.text = self.haItem.name;
    styleLabel.text = self.haItem.style;
    memberLabel.text = self.haItem.member;
    followerLabel.text = [NSString stringWithFormat:@"%@人关注",self.haItem.follower];
}

- (void)downloadFinish:(NSNotification *)notification
{
    DownloadManager *dm = [DownloadManager sharedManager];
    self.haItem = [[dm.resultDict objectForKey:notification.object] retain];
    dataArray = [self.haItem.playlistArray retain];
    [self loadContents];
    [musicTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    PlaylistItem *item = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaylistItem *item = [dataArray objectAtIndex:indexPath.row];
    MusicListViewController *mvc = [[MusicListViewController alloc] init];
    mvc.plItem = item;
    [self.navigationController pushViewController:mvc animated:YES];
    [mvc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [activeVC release];
    [albumVC release];
    [dynamicVC release];
    [leaveMsgVC release];
    self.haItem = nil;
    [dataArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.artist_id = nil;
    [headImageView release];
    [nameLabel release];
    [styleLabel release];
    [memberLabel release];
    [followerLabel release];
    [buttonArray release];
    [musicTableView release];
    [upScrollView release];
    [super dealloc];
}

- (IBAction)likeClick:(id)sender {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self presentViewController:lvc animated:YES completion:^{

    }];
    [lvc release];
}

- (IBAction)shareClick:(id)sender {
    ShareActionSheet *sas = [[ShareActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    AppDelegate *appDelegate = ShareApp;
    
    //将要分享的图片数据传过去
    NSData *imgData = UIImagePNGRepresentation(headImageView.image);
    if (!imgData) {
        imgData = UIImageJPEGRepresentation(headImageView.image, 0.8f);
    }
    appDelegate.imgData = imgData;
    [sas showFromTabBar:self.tabBarController.tabBar];
    [sas release];
}

- (void)hiddenAllButtonFlag
{
    for (CustomButton *button in buttonArray) {
        [button hiddenCurrentLabel];
    }
}

- (BOOL)removeChildViewController
{
    [self hiddenAllButtonFlag];
    NSArray *array = [NSArray arrayWithObjects:activeVC,albumVC,dynamicVC,leaveMsgVC, nil];
    for (UITableViewController *tableVC in array) {
        if (tableVC.tableView.tableHeaderView) {
            [upScrollView retain];
            tableVC.tableView.tableHeaderView = nil;
            [tableVC.tableView removeFromSuperview];
            [tableVC willMoveToParentViewController:nil];
            [tableVC removeFromParentViewController];
            return YES;
        }
    }
    return NO;
}

- (void)add_ChildViewController:(UITableViewController *)tableVC
{ 
    if ([self removeChildViewController] == NO) {
        [upScrollView retain];
        musicTableView.tableHeaderView = nil;
    }
    tableVC.tableView.tableHeaderView = upScrollView;
    tableVC.tableView.frame = musicTableView.frame;
    [self addChildViewController:tableVC];
    [self.view addSubview:tableVC.tableView];
    [tableVC didMoveToParentViewController:self];
}

- (IBAction)musicLibraryClick:(id)sender {
    if ([self removeChildViewController]) {
         musicTableView.tableHeaderView = upScrollView;
    }
     [(CustomButton *)sender showCurrentLabel];
}

- (IBAction)activityClick:(id)sender {
    if (activeVC.tableView.superview) {
        return;
    }
    [self add_ChildViewController:activeVC];
    [(CustomButton *)sender showCurrentLabel];
}

- (IBAction)albumClick:(id)sender {
    if (albumVC.tableView.tableHeaderView) {
        return;
    }
    
    [self add_ChildViewController:albumVC];
    [(CustomButton *)sender showCurrentLabel];
}

- (IBAction)dynamicClick:(id)sender {
    if (dynamicVC.tableView.tableHeaderView) {
        return;
    }
    
    [self add_ChildViewController:dynamicVC];
    [(CustomButton *)sender showCurrentLabel];
}

- (IBAction)leaveMsgClick:(id)sender {
    if (leaveMsgVC.tableView.tableHeaderView) {
        return;
    }
    
    [self add_ChildViewController:leaveMsgVC];
    [(CustomButton *)sender showCurrentLabel];
}
@end







