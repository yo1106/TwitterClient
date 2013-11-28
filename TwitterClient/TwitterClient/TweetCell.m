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
    [self.tweetTextLabel sizeToFit];
    frame.size.height = self.tweetTextLabel.frame.size.height;
    self.tweetTextLabel.frame = frame;
    
    
    //    cell.tweetUserNameLabel.text = tweetEntity.userEntity.name;
    self.tweetCreated.text = self.tweetEntity.created_at;
    NSString *imageURL = self.tweetEntity.userEntity.profileImageURL;
    [self.tweetUserAvatarImageView loadImage:imageURL];
    self.tweetUserAvatarImageView.tag = [self.tweetEntity.userEntity.twitterId intValue];


    if(self.avatarImageViewPressed){
        [self.tweetUserAvatarImageView addGestureRecognizer:self.avatarImageViewPressed];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressAvatarImageView:(id)sender{
    [self avatarImageViewPressed];
}

-(CGFloat)calculateCellHeightWithText:(NSString *)text
{
    // TODO : UILabel の高さ計算 [2]
    // HINT : (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
    
    //表示最大サイズ
//    CGSize bounds = CGSizeMake(self.tweetTextLabel.frame.size.width, CGFLOAT_MAX);
//    NSLineBreakMode mode = self.tweetTextLabel.lineBreakMode;//改行する
//    CGSize size = [text sizeWithFont:self.tweetTextLabel.font constrainedToSize:bounds lineBreakMode:mode];
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
