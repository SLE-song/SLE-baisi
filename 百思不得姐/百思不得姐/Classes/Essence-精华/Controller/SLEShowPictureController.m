//
//  SLEShowPictureController.m
//  百思不得姐
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEShowPictureController.h"
#import <UIImageView+WebCache.h>
#import "SLETopic.h"
#import <SVProgressHUD.h>
#import <DALabeledCircularProgressView.h>

@interface SLEShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 显示的图片 */
@property (weak ,nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation SLEShowPictureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupProgressView];
    
   

}

- (void)setupProgressView
{
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = [UIScreen mainScreen].bounds.size.width;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > [UIScreen mainScreen].bounds.size.height) {// 整个高度超出屏幕高度
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.sle_size = CGSizeMake(pictureW, pictureH);
        imageView.sle_centerY = [UIScreen mainScreen].bounds.size.height *0.5;
    }
    
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.topic.pictureProgress = 1.0* receivedSize / expectedSize;
        [self.progressView setProgress:self.topic.pictureProgress animated:YES];
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.topic.pictureProgress *100];
        self.progressView.progressLabel.textColor = [UIColor whiteColor];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
    }];




}

- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)save {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

    if (error) {
        
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        
    }else{
    
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    
    }



}





@end
