//
//  Tweet.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "Tweet.h"


@implementation TweetEntity

-(void)setEntity:(NSDictionary*)dict{    
    self.text = dict[@"text"];
    self.created_at = dict[@"created_at"];
    self.tweetId = dict[@"id"];
    
    if([[dict[@"entities"] allKeys] containsObject:@"media"]){
        self.mediaURL = dict[@"entities"][@"media"][0][@"media_url"];
    }

    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]]];//これがないと動かない。
//  [inputDateFormatter setLocale:[NSLocale currentLocale]];　//こうしたら動かないから気をつけて！！！！！
    [inputDateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];

    self.createdDate = [inputDateFormatter dateFromString:self.created_at];
    UserEntity *userEntity = [[UserEntity alloc] init];
    [userEntity setEntity:dict[@"user"]];
    self.userEntity = userEntity;
}

@end