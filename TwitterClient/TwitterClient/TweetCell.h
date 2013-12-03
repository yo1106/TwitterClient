//
//  TweetCell.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"

#import "UIImageView+Action.h"
#import "UIAsyncImageView.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIAsyncImageView *tweetUserAvatarImageView;
@property (strong, nonatomic) IBOutlet UIAsyncImageView *mediaImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetCreated;

@property (strong, nonatomic) void(^avatarImageViewPressed)();


@property (nonatomic, strong) TweetEntity *tweetEntity;


-(CGFloat)calculateCellHeightWithText:(NSString *)text;

@end
