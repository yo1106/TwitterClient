//
//  FollowingViewController.h
//  TwitterClient
//
//  Created by yukichang on 2013/12/02.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TwitterClient.h"

#import "User.h"

#import "UserCell.h"

#import "UserViewController.h"

@interface FollowingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UserEntity *owner;
@property (nonatomic, strong) NSMutableArray *users;
@property (strong, nonatomic) NSString *nextCursor;

@end
