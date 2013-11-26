//
//  TimelineViewController.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "TimelineViewController.h"

#import "TweetCell.h"
#import "Tweet.h"

@interface TimelineViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) TweetCell *cellForCalcHeight;


@end

@implementation TimelineViewController

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
    // Do any additional setup after loading the view from its nib.

    self.tweets = [[NSMutableArray alloc] init];

    
//    self.title = @"タイムライン";
    self.title = self.lastTweetId;

    [self getTimeline];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];

    self.cellForCalcHeight = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
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
//    NSLog(@"numberOfRowsInSection:%lu", (unsigned long)[self.tweets count]);
    return [self.tweets count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetEntity *tweetEntity = self.tweets[indexPath.row];
//    NSLog(@"%@", tweetEntity.text);
//    NSLog(@"%f", [self.cellForCalcHeight calculateCellHeightWithText:tweetEntity.text]);
    CGFloat height = [self.cellForCalcHeight calculateCellHeightWithText:tweetEntity.text];
    CGFloat result = height < 100 ? 100 : height;
//    NSLog(@"height:%f, result:%f, text:%@", height, result, tweetEntity.text);
    return result;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    if([self.tweets count] > indexPath.row){

        TweetEntity *tweetEntity = self.tweets[indexPath.row];
        cell.tweetTextLabel.text = tweetEntity.text;
        cell.tweetTextLabel.numberOfLines = 0;

        // こいつを書いておかないと、labelの横幅が勝手に変わってしまってデザインが崩れる。
        CGRect frame = cell.tweetTextLabel.frame;
        [cell.tweetTextLabel sizeToFit];
        frame.size.height = cell.tweetTextLabel.frame.size.height;
        cell.tweetTextLabel.frame = frame;


        cell.tweetUserNameLabel.text = [NSString stringWithFormat:@"%@ %@", tweetEntity.tweetId, tweetEntity.userEntity.name];
        cell.tweetCreated.text = tweetEntity.created_at;
        NSString *imageURL = tweetEntity.userEntity.profileImageURL;
        [cell.tweetUserAvatarImageView loadImage:imageURL];
    }

    return cell;
}

- (void)getTimeline {
    //Twitter APIのURLを準備
    //今回は「statuses/home_timeline.json」を利用
    NSString *apiURL = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
    
    //iOS内に保存されているTwitterのアカウント情報を取得
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType =
    [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //ユーザーにTwitterの認証情報を使うことを確認
    [store requestAccessToAccountsWithType:twitterAccountType
                                   options:nil
                                completion:^(BOOL granted, NSError *error) {
                                    //ユーザーが拒否した場合
                                    if (!granted) {
                                        NSLog(@"Twitterへの認証が拒否されました。");
                                        //                                        [self alertAccountProblem];
                                        //ユーザーの了解が取れた場合
                                    } else {
                                        //デバイスに保存されているTwitterのアカウント情報をすべて取得
                                        NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
                                        //Twitterのアカウントが1つ以上登録されている場合
                                        if ([twitterAccounts count] > 0) {
                                            //0番目のアカウントを使用
                                            ACAccount *account = [twitterAccounts objectAtIndex:0];
                                            //認証が必要な要求に関する設定
                                            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                                            [params setObject:@"1" forKey:@"include_entities"];
                                            [params setObject:@"10" forKey:@"count"];

                                            if([self.tweets count]){
                                                [params setObject:self.lastTweetId forKey:@"max_id"];
                                            }
                                            NSLog(@"params:%@", params);
                                            //リクエストを生成
                                            NSURL *url = [NSURL URLWithString:apiURL];
                                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                    requestMethod:SLRequestMethodGET
                                                                                              URL:url parameters:params];
                                            //リクエストに認証情報を付加
                                            [request setAccount:account];
                                            //ステータスバーのActivity Indicatorを開始
                                            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                                            //リクエストを発行
                                            [request performRequestWithHandler:^(
                                                                                 NSData *responseData,
                                                                                 NSHTTPURLResponse *urlResponse,
                                                                                 NSError *error) {
                                                //Twitterからの応答がなかった場合
                                                if (!responseData) {
                                                    // inspect the contents of error
                                                    NSLog(@"response error: %@", error);
                                                    //Twitterからの返答があった場合
                                                } else {
                                                    //JSONの配列を解析し、TweetをNSArrayの配列に入れる
                                                    NSError *jsonError;
                                                    NSArray *tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                      options: NSJSONReadingMutableLeaves error:&jsonError];
                                                    
                                                    for (NSDictionary *tweet in tweets){
                                                        TweetEntity *tweetEntity = [[TweetEntity alloc] init];
                                                        [tweetEntity setEntity:tweet];
                                                        [self.tweets addObject:tweetEntity];
                                                    }
                                                    //ページングのために一つ消して、最後のIDとして保持
                                                    TweetEntity *lastTweet = [self.tweets lastObject];
                                                    self.lastTweetId = lastTweet.tweetId;
                                                    NSLog(@"%@", self.lastTweetId);
//                                                    self.lastTweetId = @"405280627789803520";
                                                    self.title = [NSString stringWithFormat:@"%@", self.lastTweetId];
                                                    
                                                    [self.tweets removeLastObject];
                                                    
                                                    //Tweet取得完了に伴い、Table Viewを更新
                                                    [self refreshTableOnFront];
                                                }
                                            }];
                                        } else {
                                            //                                            [self alertAccountProblem];
                                        }
                                    } 
                                }];
}

//最後まで来たら呼ばれる？
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    
    if(![UIApplication sharedApplication].networkActivityIndicatorVisible){
        [self getTimeline];
    }

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
