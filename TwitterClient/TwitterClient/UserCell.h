//
//  UserCell.h
//  TwitterClient
//
//  Created by yukichang on 2013/12/02.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import "UIAsyncImageView.h"

@interface UserCell : UITableViewCell

@property (strong, nonatomic) UserEntity *userEntity;


@property (strong, nonatomic) IBOutlet UIAsyncImageView *userAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userScreenNameLabel;

@property (strong, nonatomic) void(^avatarImageViewPressed)();


@end
