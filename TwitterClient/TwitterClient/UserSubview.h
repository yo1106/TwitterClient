//
//  UserView.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/29.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

#import "UIImageView+Action.h"
#import "UIAsyncImageView.h"

#import "FollowingViewController.h"

@interface UserSubview : UIView

@property (strong, nonatomic) UserEntity *userEntity;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userScreenName;
@property (strong, nonatomic) IBOutlet UIButton *tweetCount;
@property (strong, nonatomic) IBOutlet UIButton *followingCount;
@property (strong, nonatomic) IBOutlet UIButton *followerCount;

@property (strong, nonatomic) IBOutlet UIAsyncImageView *userCoverImageView;
@property (weak, nonatomic) IBOutlet UIAsyncImageView *userAvatarImageView;


@property (strong, nonatomic) void(^followingCountButtonPressed)();

@property (strong, nonatomic) void(^avatarImageViewPressed)();



- (IBAction)pressFollowingButton:(id)sender;

@end
