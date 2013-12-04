//
//  TweetCell.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];

    self.tweetUserNameLabel.text = self.tweetEntity.userEntity.name;
    
    self.tweetTextLabel.text = self.tweetEntity.text;
    self.tweetTextLabel.numberOfLines = 0;
    
    // こいつを書いておかないと、labelの横幅が勝手に変わってしまってデザインが崩れる。
    CGRect frame = self.tweetTextLabel.frame;
    NSInteger beforeHeight = frame.size.height;
    [self.tweetTextLabel sizeToFit];
    frame.size.height = self.tweetTextLabel.frame.size.height;
    self.tweetTextLabel.frame = frame;

    NSInteger labelHeightDiff = frame.size.height - beforeHeight;
    
    //これを書いておかないと、セルの高さが変わるのと一緒に画像サイズが変わっちゃう。
    self.tweetUserAvatarImageView.frame = CGRectMake(self.tweetUserAvatarImageView.frame.origin.x, self.tweetUserAvatarImageView.frame.origin.y, 44, 44);
    
    //    cell.tweetUserNameLabel.text = tweetEntity.userEntity.name;
    NSLog(@"%@", [self.tweetEntity.createdDate dateTimeAgo]);
//    NSDate *date = [[NSDate alloc] init]
    self.tweetCreated.text = [self.tweetEntity.createdDate dateTimeAgo];

    
    NSString *imageURL = self.tweetEntity.userEntity.profileImageURL;
    [self.tweetUserAvatarImageView loadImage:imageURL];
    self.tweetUserAvatarImageView.tag = [self.tweetEntity.userEntity.twitterId intValue];

    if(self.tweetEntity.mediaURL){
        [self.mediaImageView loadImage:self.tweetEntity.mediaURL];

        CGRect mediaImageViewFrame = self.mediaImageView.frame;
        mediaImageViewFrame.origin.y = mediaImageViewFrame.origin.y+labelHeightDiff;
        self.mediaImageView.frame = mediaImageViewFrame;
        

    }

    if(self.avatarImageViewPressed){
        self.tweetUserAvatarImageView.imageViewPressedBlock = self.avatarImageViewPressed;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(CGFloat)calculateCellHeightWithText:(NSString *)text
{
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: self.tweetTextLabel.font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.tweetTextLabel.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
        
    CGFloat top = 20.0f;
    CGFloat bottom = 20.0f;
    return size.height + top + bottom;
}

@end
