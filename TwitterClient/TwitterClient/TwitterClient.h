//
//  TwitterClient.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/27.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>


@interface TwitterClient : NSObject

+ (TwitterClient *)sharedInstance;

- (void)fetchTimeline:(NSInteger)count maxId:(NSString*)maxId
              success:(void (^)(NSData *responseData,
                                NSHTTPURLResponse *urlResponse,
                                NSError *error))success;

- (void)fetchUsersLookup:(NSString*)screenName success:(void (^)(NSData *responseData,
                                                             NSHTTPURLResponse *urlResponse,
                                                             NSError *error))success;

- (void)fetchFriendsList:(NSString*)screenName count:(NSInteger)count cursor:(NSString*)cursor
                 success:(void (^)(NSData *responseData,
                                   NSHTTPURLResponse *urlResponse,
                                   NSError *error))success;

- (void)postImageTweet:(NSString*)text image:(UIImage*)image success:(void (^)(NSData *responseData,
                                NSHTTPURLResponse *urlResponse,
                                NSError *error))success;

- (void)postTweet:(NSString*)text success:(void (^)(NSData *responseData,
                                                   NSHTTPURLResponse *urlResponse,
                                                   NSError *error))success;



@end
