//
//  User.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/28.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "User.h"


@implementation UserEntity

-(void)setEntity:(NSDictionary*)dict{
    self.profileImageURL = dict[@"profile_image_url"];
    self.name = dict[@"name"];
    self.twitterId = dict[@"id"];
    self.screenName = dict[@"screen_name"];
}

@end