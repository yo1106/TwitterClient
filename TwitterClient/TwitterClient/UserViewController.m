//
//  UserViewController.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/29.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UserSubview *view = [[UserSubview alloc] init];
    view.userEntity = self.userEntity;
    
    view.followingCountButtonPressed = ^(void){
        FollowingViewController *vc = [[FollowingViewController alloc] initWithNibName:nil bundle:nil];
        vc.owner = self.userEntity;
        [self.navigationController pushViewController:vc animated:YES];
    };
    view.avatarImageViewPressed = ^(void){
        NSLog(@"press!");
    };
    self.view = view;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
