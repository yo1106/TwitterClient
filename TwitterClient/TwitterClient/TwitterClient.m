//
//  TwitterClient.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/27.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "TwitterClient.h"

@implementation TwitterClient

static TwitterClient* sharedTwitterClient = nil;
static ACAccountStore *store = nil;
static ACAccountType *twitterAccountType = nil;
static NSString *apiBaseURL = @"https://api.twitter.com/1.1/";

+ (TwitterClient*)sharedInstance{
    
    @synchronized( self ) {
        if(sharedTwitterClient == nil){
            sharedTwitterClient = [[self alloc] init];

            //iOS内に保存されているTwitterのアカウント情報を取得
            store = [[ACAccountStore alloc] init];
            twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        }
    }
    return sharedTwitterClient;
}

- (void)postImageTweet:(NSString*)text image:(UIImage*)image success:(void (^)(NSData *responseData,
                            NSHTTPURLResponse *urlResponse,
                            NSError *error))success{
    //デバイスに保存されているTwitterのアカウント情報をすべて取得
    NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
    //Twitterのアカウントが1つ以上登録されている場合
    if ([twitterAccounts count] > 0) {
        //0番目のアカウントを使用
        ACAccount *account = [twitterAccounts objectAtIndex:0];
        //認証が必要な要求に関する設定
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        [params setObject:text forKey:@"status"];

        NSLog(@"%@", params);
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"statuses/update_with_media.json"]];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodPOST
                                                          URL:url parameters:params];
        //リクエストに認証情報を付加
        [request setAccount:account];
        if(image){
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);

            [request addMultipartData:imageData withName:@"media" type:@"image/jpeg" filename:nil];
        }
        
        
        //リクエストを発行
        [request performRequestWithHandler:success];
    }
}

- (void)postTweet:(NSString*)text success:(void (^)(NSData *responseData,
                                                           NSHTTPURLResponse *urlResponse,
                                                           NSError *error))success{
    //デバイスに保存されているTwitterのアカウント情報をすべて取得
    NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
    //Twitterのアカウントが1つ以上登録されている場合
    if ([twitterAccounts count] > 0) {
        //0番目のアカウントを使用
        ACAccount *account = [twitterAccounts objectAtIndex:0];
        //認証が必要な要求に関する設定
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        [params setObject:text forKey:@"status"];
        
        NSLog(@"%@", params);
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"statuses/update.json"]];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodPOST
                                                          URL:url parameters:params];
        //リクエストに認証情報を付加
        [request setAccount:account];

        //リクエストを発行
        [request performRequestWithHandler:success];
    }
}

- (void)fetchTimeline:(NSInteger)count maxId:(NSString*)maxId
            success:(void (^)(NSData *responseData,
                              NSHTTPURLResponse *urlResponse,
                              NSError *error))success{
    
    //デバイスに保存されているTwitterのアカウント情報をすべて取得
    NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
    //Twitterのアカウントが1つ以上登録されている場合
    if ([twitterAccounts count] > 0) {
        //0番目のアカウントを使用
        ACAccount *account = [twitterAccounts objectAtIndex:0];
        //認証が必要な要求に関する設定
        NSLog(@"fetchTimeline");
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"1" forKey:@"include_entities"];
        [params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
        
        if(maxId){
            [params setObject:maxId forKey:@"max_id"];
        }
        //リクエストを生成
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"statuses/home_timeline.json"]];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodGET
                                                          URL:url parameters:params];
        //リクエストに認証情報を付加
        [request setAccount:account];
        //ステータスバーのActivity Indicatorを開始
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //リクエストを発行
        [request performRequestWithHandler:success];
    }
}

- (void)fetchFriendsList:(NSString*)screenName count:(NSInteger)count cursor:(NSString*)cursor
                 success:(void (^)(NSData *responseData,
                                   NSHTTPURLResponse *urlResponse,
                                   NSError *error))success{
    //デバイスに保存されているTwitterのアカウント情報をすべて取得
    NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
    //Twitterのアカウントが1つ以上登録されている場合
    if ([twitterAccounts count] > 0) {
        //0番目のアカウントを使用
        ACAccount *account = [twitterAccounts objectAtIndex:0];
        //認証が必要な要求に関する設定
        NSLog(@"fetchFriendsList");
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
        [params setObject:screenName forKey:@"screen_name"];

        //リクエストを生成
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"friends/list.json"]];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodGET
                                                          URL:url parameters:params];
        //リクエストに認証情報を付加
        [request setAccount:account];
        //ステータスバーのActivity Indicatorを開始
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //リクエストを発行
        [request performRequestWithHandler:success];
    }
    
}
- (void)fetchUsersLookup:(NSString*)screenName
                success:(void (^)(NSData *responseData,
                                  NSHTTPURLResponse *urlResponse,
                                  NSError *error))success{
    //デバイスに保存されているTwitterのアカウント情報をすべて取得
    NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];

    //Twitterのアカウントが1つ以上登録されている場合
    if ([twitterAccounts count] > 0) {
        //0番目のアカウントを使用
        ACAccount *account = [twitterAccounts objectAtIndex:0];
        //認証が必要な要求に関する設定
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:screenName forKey:@"screen_name"];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"users/lookup.json"]];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodGET
                                                          URL:url parameters:params];
        NSLog(@"%@", params);
        //リクエストに認証情報を付加
        [request setAccount:account];
        //ステータスバーのActivity Indicatorを開始
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //リクエストを発行
        [request performRequestWithHandler:success];
    }
}

@end
