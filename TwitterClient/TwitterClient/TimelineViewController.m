//
//  TimelineViewController.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "TimelineViewController.h"

#import "TwitterClient.h"

#import "TweetViewController.h"


#import "TweetCell.h"
#import "Tweet.h"
const int requestLimit = 50;

@interface TimelineViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) TweetCell *tweetCell;


@end

@implementation TimelineViewController

static UIRefreshControl *refreshControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)fetch:(NSInteger)count maxId:(NSString*)maxId
{

    TwitterClient *client = [TwitterClient sharedInstance];
    [client fetchTimeline:count+1 maxId:maxId success:^(NSData *responseData,
                                               NSHTTPURLResponse *urlResponse,
                                               NSError *error){
        NSError *jsonError;
        id tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                          options: NSJSONReadingMutableLeaves error:&jsonError];

        if([NSStringFromClass([tweets class]) isEqual: @"__NSCFDictionary"]){

        }else{
            for (NSDictionary *tweet in tweets){
                TweetEntity *tweetEntity = [[TweetEntity alloc] init];
                [tweetEntity setEntity:tweet];
                [self.tweets addObject:tweetEntity];
            }
            
            //ページングのために一つ消して、最後のIDとして保持
            TweetEntity *firstTweet = [self.tweets firstObject];
            TweetEntity *lastTweet = [self.tweets lastObject];
//            self.lastTweetId = @"405572873110028288";
            self.lastTweetId = lastTweet.tweetId;

            [self.tweets removeLastObject];
            
            
            [self refreshTableOnFront];
        }

    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.tweets = [[NSMutableArray alloc] init];
    self.title = @"タイムライン";

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetImageCell" bundle:nil] forCellReuseIdentifier:@"TweetImageCell"];
    self.tweetCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    [self fetch:requestLimit maxId:0];

    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tweets count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetEntity *tweetEntity = self.tweets[indexPath.row];
    NSInteger addHeight = 0;
    NSInteger minHeight = 100;
    
    //メディア画像が設定されている場合
    if(tweetEntity.mediaURL){
        addHeight = 108;//TODO: ハードコーディングはよくないよね。
    }

    CGFloat height = [self.tweetCell calculateCellHeightWithText:tweetEntity.text];
    CGFloat result = height < minHeight ? minHeight : height;
    return result+addHeight;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetEntity *tweetEntity = self.tweets[indexPath.row];
    static NSString *CellIdentifier;

    if(tweetEntity.mediaURL){
         CellIdentifier = @"TweetImageCell";
    } else {
        CellIdentifier = @"TweetCell";
    }

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    if([self.tweets count] > indexPath.row){

        cell.tweetEntity = tweetEntity;
        
        cell.avatarImageViewPressed = ^(void){
            
            UserViewController *vc = [[UserViewController alloc] initWithNibName:nil bundle:nil];
            vc.userEntity = tweetEntity.userEntity;
            [self.navigationController pushViewController:vc animated:YES];
            
        };

//        [cell.mediaImageView setupImageViewerWithDatasource:self initialIndex:indexPath.row onOpen:^(void){
//            NSLog(@"open");
//        } onClose:^(void){
//            NSLog(@"close");
//        }];
        [cell.mediaImageView setupImageViewer];
    }

    if([self.tweets count] < indexPath.row+3){
        [self fetch:requestLimit maxId:self.lastTweetId];
    }
    
    return cell;
}

// セルをタップで呼ばれる
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetViewController *vc = [[TweetViewController alloc] init];
    TweetEntity *tweetEntity = self.tweets[indexPath.row];
    vc.tweetEntity = tweetEntity;

    vc.avatarImageViewPressed = ^(void){
        [self pushUserVC:tweetEntity];
    };
    
    
    [self.navigationController pushViewController:vc animated:YES];


}

- (void)pushUserVC:(TweetEntity*)tweetEntity
{
    UserViewController *vc = [[UserViewController alloc] initWithNibName:nil bundle:nil];
    vc.userEntity = tweetEntity.userEntity;
    [self.navigationController pushViewController:vc animated:YES];
}

//最後まで来たら呼ばれる？
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    


}

- (void)refresh
{
    [self.tweets removeAllObjects];
    [self fetch:requestLimit maxId:0];
    [refreshControl endRefreshing];
    [self refreshTableOnFront];
}

//フロント側でテーブルを更新
- (void) refreshTableOnFront {
    [self performSelectorOnMainThread:@selector(refreshTable) withObject:self waitUntilDone:TRUE];
}

//テーブルの内容をセット
- (void)refreshTable {
    
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //最新の内容にテーブルをセット
    [self.tableView reloadData];
}
@end
