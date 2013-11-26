//
//  TweetCell.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAsyncImageView.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIAsyncImageView *tweetUserAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetCreated;

-(CGFloat)calculateCellHeightWithText:(NSString *)text;


@end
