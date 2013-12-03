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
    self.profileBackgroundImageURL = dict[@"profile_background_image_url"];
    self.followersCount = dict[@"followers_count"];
    self.followingCount = dict[@"friends_count"];
    self.tweetsCount = dict[@"statuses_count"];
    self.name = dict[@"name"];
    self.twitterId = dict[@"id"];
    self.screenName = dict[@"screen_name"];
    
}

-(void)fetchLookup{
    TwitterClient *client = [TwitterClient sharedInstance];
    [client fetchUsersLookup:self.screenName success:^(NSData *responseData,
                                                        NSHTTPURLResponse *urlResponse,
                                                        NSError *error){
        NSError *jsonError;
        id tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                    options: NSJSONReadingMutableLeaves error:&jsonError];
        
        if([NSStringFromClass([tweets class]) isEqual: @"__NSCFDictionary"]){

        }else{
            self.profileBannerURL = [NSString stringWithFormat:@"%@/%@", tweets[0][@"profile_banner_url"], @"mobile_retina"];
        }
        
    }];
}

-(NSString*)profileBannerURL{
    if(!_profileBannerURL){
        [self fetchLookup];
    }

    return _profileBannerURL;
}

@end