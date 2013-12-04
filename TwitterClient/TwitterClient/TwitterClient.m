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
static NSArray *accounts = nil;
static ACAccount *account = nil;

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

- (void)request:(SLRequest*)request success:(void (^)(NSData *responseData,
                                                      NSHTTPURLResponse *urlResponse,
                                                      NSError *error))success{
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {

        accounts = [store accountsWithAccountType:twitterAccountType];
        
        //Twitterのアカウントが1つ以上登録されている場合
        if ([accounts count] > 0) {
            //0番目のアカウントを使用
            account = [accounts objectAtIndex:0];
            
            //リクエストに認証情報を付加
            [request setAccount:account];

            //ステータスバーのActivity Indicatorを開始
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
            //リクエストを発行
            [request performRequestWithHandler:success];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"有効なTwitterアカウントがありません"
                                                            delegate:self
                                                  cancelButtonTitle:@"キャンセル" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];
    

}

- (void)postImageTweet:(NSString*)text image:(UIImage*)image success:(void (^)(NSData *responseData,
                            NSHTTPURLResponse *urlResponse,
                            NSError *error))success{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:text forKey:@"status"];

    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"statuses/update_with_media.json"]];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodPOST
                                                      URL:url parameters:params];

    if(image){
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);

        [request addMultipartData:imageData withName:@"media" type:@"image/jpeg" filename:nil];
    }
        

    [self request:request success:success];
}

- (void)postTweet:(NSString*)text success:(void (^)(NSData *responseData,
                                                           NSHTTPURLResponse *urlResponse,
                                                           NSError *error))success{

    //認証が必要な要求に関する設定
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:text forKey:@"status"];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"statuses/update.json"]];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodPOST
                                                      URL:url parameters:params];
    
    //リクエストを発行
    [self request:request success:success];
}

- (void)fetchTimeline:(NSInteger)count maxId:(NSString*)maxId
            success:(void (^)(NSData *responseData,
                              NSHTTPURLResponse *urlResponse,
                              NSError *error))success{

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


        //リクエストを発行
    [self request:request success:success];
}

- (void)fetchFriendsList:(NSString*)screenName count:(NSInteger)count cursor:(NSString*)cursor
                 success:(void (^)(NSData *responseData,
                                   NSHTTPURLResponse *urlResponse,
                                   NSError *error))success{


    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
    [params setObject:screenName forKey:@"screen_name"];
    
    if(cursor){
        [params setObject:cursor forKey:@"cursor"];
    }
    
    //リクエストを生成
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"friends/list.json"]];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:url parameters:params];

    //リクエストを発行
    [self request:request success:success];
    
}
- (void)fetchUsersLookup:(NSString*)screenName
                success:(void (^)(NSData *responseData,
                                  NSHTTPURLResponse *urlResponse,
                                  NSError *error))success{
    //認証が必要な要求に関する設定
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:screenName forKey:@"screen_name"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiBaseURL, @"users/lookup.json"]];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:url parameters:params];

    //リクエストを発行
    [self request:request success:success];
}

@end
