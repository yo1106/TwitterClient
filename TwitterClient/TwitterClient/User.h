//
//  User.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/28.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageURL;
-(void)setEntity:(NSDictionary*)dict;

@end