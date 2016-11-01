//
//  SLETopicPictureView.m
//  百思不得姐
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "SLETopic.h"
#import <DALabeledCircularProgressView.h>
#import "SLEShowPictureController.h"


@interface SLETopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end



@implementation SLETopicPictureView

+ (instancetype)sle_pictureView
{

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;


}

- (void)setTopic:(SLETopic *)topic
{

    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.topic.pictureProgress = 1.0* receivedSize / expectedSize;
        [self.progressView setProgress:self.topic.pictureProgress animated:YES];
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.topic.pictureProgress *100];
        self.progressView.progressLabel.textColor = [UIColor whiteColor];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        if (!topic.isBigPicture)   return ;
        
        // 开启图片上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
        
        CGFloat width = topic.pictureFrame.size.width;
        CGFloat height = topic.pictureFrame.size.width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭图片上下文
        UIGraphicsEndImageContext();
        
    }];
    
    NSString *gifExtension = [topic.large_image pathExtension];
    
    
  
    self.gifView.hidden = ![gifExtension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
    
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    }

}

- (void)awakeFromNib
{

    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 4;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (IBAction)showPicture
{
    SLEShowPictureController *showPicture = [[SLEShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];


}

@end
