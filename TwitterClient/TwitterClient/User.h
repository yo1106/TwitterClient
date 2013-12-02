//
//  User.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/28.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TwitterClient.h"

@interface UserEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *profileBackgroundImageURL;
@property (nonatomic, strong) NSString *profileBannerURL;
@property (nonatomic, strong) NSString *followersCount;
@property (nonatomic, strong) NSString *followingCount;
@property (nonatomic, strong) NSString *tweetsCount;
-(void)setEntity:(NSDictionary*)dict;

@end