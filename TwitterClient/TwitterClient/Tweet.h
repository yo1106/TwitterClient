//
//  Tweet.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageURL;
-(void)setEntity:(NSDictionary*)dict;

@end

@interface TweetEntity : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) UserEntity *userEntity;

-(void)setEntity:(NSDictionary*)dict;

@end