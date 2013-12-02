//
//  UserView.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/29.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "UserSubview.h"

@implementation UserSubview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UINib *nib = [UINib nibWithNibName:@"UserSubview" bundle:nil];
        UserSubview *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
        [self addSubview:view];
    }
    NSLog(@"initWithFrame");
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews");
    [super layoutSubviews];

    self.userNameLabel.text = self.userEntity.name;
    self.userScreenName.text = self.userEntity.screenName;
    [self.userAvatarImageView loadImage:self.userEntity.profileImageURL];
    [self.userCoverImageView loadImage:self.userEntity.profileBannerURL];

    NSLog(@"%@", self.userEntity.followingCount);
  
    [self.followerCount setTitle:[NSString stringWithFormat:@"%@", self.userEntity.followersCount] forState:UIControlStateNormal];
    
    [self.followingCount setTitle:[NSString stringWithFormat:@"%@", self.userEntity.followingCount] forState:UIControlStateNormal];
//    [self.followerCount setTitle:self.userEntity.followersCount forState:self.followerCount.state];
}

@end
