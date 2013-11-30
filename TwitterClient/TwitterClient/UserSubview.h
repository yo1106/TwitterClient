//
//  UserView.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/29.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UIAsyncImageView.h"

@interface UserSubview : UIView

@property (strong, nonatomic) UserEntity *userEntity;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userScreenName;
@property (strong, nonatomic) IBOutlet UIButton *tweetCount;
@property (strong, nonatomic) IBOutlet UIButton *followingCount;
@property (strong, nonatomic) IBOutlet UIButton *followerCount;



@property (strong, nonatomic) IBOutlet UIAsyncImageView *userAvatarImageView;

@end
