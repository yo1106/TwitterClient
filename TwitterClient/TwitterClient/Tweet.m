//
//  Tweet.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "Tweet.h"

@implementation UserEntity

-(void)setEntity:(NSDictionary*)dict{
    self.profileImageURL = dict[@"profile_image_url"];
    self.name = dict[@"name"];
    self.screenName = dict[@"screen_name"];
}

@end

@implementation TweetEntity

-(void)setEntity:(NSDictionary*)dict{    
    self.text = dict[@"text"];
    self.created_at = dict[@"created_at"];
    self.tweetId = dict[@"id"];
    
    UserEntity *userEntity = [[UserEntity alloc] init];
    [userEntity setEntity:dict[@"user"]];
    self.userEntity = userEntity;
}

@end