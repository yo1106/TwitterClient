//
//  UIImageView+Action.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/29.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "UIImageView+Action.h"
#import <objc/runtime.h>

static char kImageViewPressedBlockKey;  // 一意に決まって変更されないアドレスを定義

@implementation UIImageView (Action)
@dynamic imageViewPressedBlock;             // アクセサは自分で定義する

// プロパティのセッタメソッド
- (void)setImageViewPressedBlock:(basicBlock)imageViewPressedBlock
{
    objc_setAssociatedObject(
                             self,                               // UIImageViewインスタンス(=self)にプロパティを持たせる
                             &kImageViewPressedBlockKey,         // 保持するオブジェクトのアドレスを
                             imageViewPressedBlock,              // 引数のBlocksオブジェクトをプロパティとして保時
                             OBJC_ASSOCIATION_COPY_NONATOMIC     // Blocksオブジェクトはcopy指定
                             );
}

// プロパティのゲッタメソッド
- (basicBlock)imageViewPressedBlock
{
    return objc_getAssociatedObject(
                                    self,                               // UIImageViewインスタンス(=self)が保持するデータを取り出す
                                    &kImageViewPressedBlockKey          // 保持されたオブジェクトのアドレス
                                    );
}

// 画像にタッチイベントの設定
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (self.imageViewPressedBlock) {
        self.imageViewPressedBlock();
    }
}

@end
