//
//  FollowingViewController.m
//  TwitterClient
//
//  Created by yukichang on 2013/12/02.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "FollowingViewController.h"

@interface FollowingViewController ()


@end

@implementation FollowingViewController

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

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    self.users = [[NSMutableArray alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    [self.view addSubview:self.tableView];
    
    self.title = @"フォロー";

    TwitterClient *client = [TwitterClient sharedInstance];
    [client fetchFriendsList:self.owner.screenName count:10 cursor:[NSString stringWithFormat:@"%d", -1] success:^(NSData *responseData,
                                                        NSHTTPURLResponse *urlResponse,
                                                        NSError *error){
        NSError *jsonError;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                    options: NSJSONReadingMutableLeaves error:&jsonError];
        
        NSArray *users = response[@"users"];
        for (NSDictionary *user in users){
            UserEntity *userEntity = [[UserEntity alloc] init];
            [userEntity setEntity:user];
            [self.users addObject:userEntity];
        }

        [self refreshTableOnFront];
        
    }];
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
    NSLog(@"numberOfRowsInSection%d", [self.users count]);
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserCell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    if([self.users count] > indexPath.row){
        
        UserEntity *userEntity = self.users[indexPath.row];
        cell.userEntity = userEntity;

    }
    
    return cell;
}

//フロント側でテーブルを更新
- (void) refreshTableOnFront {
//    [self performSelectorOnMainThread:@selector(refreshTable) withObject:nil waitUntilDone:NO];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

// セルの高さを変える奴
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


//テーブルの内容をセット
- (void)refreshTable {
    
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //最新の内容にテーブルをセット
    [self.tableView reloadData];
}

@end
