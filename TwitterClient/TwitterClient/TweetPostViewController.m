//
//  TweetPostViewController.m
//  TwitterClient
//
//  Created by yukichang on 2013/11/27.
//  Copyright (c) 2013年 yukichang. All rights reserved.
//

#import "TweetPostViewController.h"

@interface TweetPostViewController ()

@end

@implementation TweetPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)pressCameraButton:(id)sender
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum だと直接写真選択画面
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 選択可能なメディアの制限 デフォルトは photo のみ。
    // movie を選択可能にするには
    // imagePickerVC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickerVC.sourceType];
    imagePickerVC.delegate = self;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)pressPostButton:(id)sender
{
    TwitterClient *client = [TwitterClient sharedInstance];
    
    //画像がImageVIEWにセットされている場合
    if(self.tweetImageView.image){
        
        [client postImageTweet:self.TweetTextView.text image:self.tweetImageView.image success:^(NSData *responseData,
                                                                                                 NSHTTPURLResponse *urlResponse,
                                                                                                 NSError *error){
            NSError *jsonError;
            id tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                        options: NSJSONReadingMutableLeaves error:&jsonError];
            
            NSLog(@"%@", tweets);
        }];
        
    }else{

        [client postTweet:self.TweetTextView.text success:^(NSData *responseData,
                                                             NSHTTPURLResponse *urlResponse,
                                                             NSError *error){
            NSError *jsonError;
            id tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                        options: NSJSONReadingMutableLeaves error:&jsonError];
            
            NSLog(@"%@", tweets);
        }];
        
        
    }

}

- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:^(void){
        [self displayEditorForImage:info[UIImagePickerControllerOriginalImage]];
    }];
}

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.postImageView.image = image;
    self.postImageView.alpha = 1;
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    // Handle cancellation here
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
