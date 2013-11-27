//
//  TweetPostViewController.h
//  TwitterClient
//
//  Created by yukichang on 2013/11/27.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TwitterClient.h"

#import "AFPhotoEditorController.h"

@interface TweetPostViewController : UIViewController<UIImagePickerControllerDelegate,
                                                        UINavigationControllerDelegate,
                                                        AFPhotoEditorControllerDelegate>
- (void)displayEditorForImage:(UIImage *)imageToEdit;

- (IBAction)pressCameraButton:(id)sender;
- (IBAction)pressPostButton:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *postImageView;

@end
