//
//  main.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/26.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "NSDate+TimeAgo.h"

int main(int argc, char * argv[])
{
    
    NSLog(@"test%@", [[[NSDate alloc] initWithTimeIntervalSince1970:0] timeAgo]);
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
