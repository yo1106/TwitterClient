//
//  UIImageView+Action.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/29.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^basicBlock)(void);

@interface UIImageView (Action)
@property (copy, nonatomic) basicBlock imageViewPressedBlock;
@end
