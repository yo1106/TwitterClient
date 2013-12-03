//
//  TweetViewController.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/27.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"

#import "UIImageView+Action.h"
#import "UIAsyncImageView.h"

@interface TweetViewController : UIViewController

@property (nonatomic, strong) TweetEntity *tweetEntity;

@property (strong, nonatomic) IBOutlet UIAsyncImageView *tweetUserAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *tweetUserNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetUserScreenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetCreatedLabel;

@property (strong, nonatomic) void(^avatarImageViewPressed)();


@end
