//
//  UserCell.m
//  TwitterClient
//
//  Created by yukichang on 2013/12/02.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userNameLabel.text = self.userEntity.name;
    self.userScreenNameLabel.text = self.userEntity.screenName;
    [self.userAvatarImageView loadImage:self.userEntity.profileImageURL];
}

@end
