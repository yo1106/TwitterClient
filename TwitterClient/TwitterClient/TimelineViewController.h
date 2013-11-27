//
//  TimelineViewController.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>


@interface TimelineViewController : UIViewController<UITableViewDelegate, UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) NSString *lastTweetId;

@end
