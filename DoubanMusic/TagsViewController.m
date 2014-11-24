

#import "TagsViewController.h"
#import "SearchItem.h"
#import "HotArtistViewController.h"

@interface TagsViewController ()

@end

@implementation TagsViewController
@synthesize tagsArray = _tagsArray;
@synthesize delegate = _delegate;

- (void)dealloc
{
    self.tagsArray = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    int i = 0;
    for (SearchTagItem *item in self.tagsArray) {
        CGRect frame = CGRectMake(i%5*65, i/5*30, 60, 20);
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.tag = 200+i;
        button.titleLabel.font = [UIFont systemFontOfSize:10+[item.size floatValue]];
        button.titleLabel.textColor = [UIColor blackColor];
        [button setTitle:item.name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button release];
        i++;
    }

}

- (void)buttonClick:(UIButton *)sender
{
    SearchTagItem *item =[self.tagsArray objectAtIndex:sender.tag-200];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"tag" forKey:@"category"];
    [dict setObject:@"name" forKey:@"subCategory"];
    [dict setObject:item.url forKey:@"subCategoryValue"];
    [dict setObject:@"artist" forKey:@"type"];
    [dict setObject:item.name forKey:@"title"];
    HotArtistViewController *hotAVC = [[HotArtistViewController alloc] init];
    hotAVC.urlDict = dict;
    [hotAVC downlaodPage:1];
    UIViewController *vc = (UIViewController *)self.delegate;
    [vc.navigationController pushViewController:hotAVC animated:YES];
    [hotAVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







