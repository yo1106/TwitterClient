//
//  TweetViewController.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/27.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setUp];
}

- (void)setUp{
    self.tweetTextLabel.text = self.tweetEntity.text;
    [self.tweetTextLabel sizeToFit];
    
    self.tweetCreatedLabel.text = self.tweetEntity.created_at;
    
    self.tweetUserNameLabel.text = self.tweetEntity.userEntity.name;
    
    [self.tweetUserAvatarImageView loadImage:self.tweetEntity.userEntity.profileImageURL];
    self.tweetUserAvatarImageView.tag = [self.tweetEntity.userEntity.twitterId intValue];

    self.tweetUserAvatarImageView.imageViewPressedBlock = self.avatarImageViewPressed;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
