//
//  UserViewController.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/28.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

@interface UserViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *userAvatarImage;
@property (strong, nonatomic) IBOutlet UIImageView *userCoverImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userScreenName;

@property (nonatomic, strong) UserEntity *userEntity;


@end
