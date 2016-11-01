//
//  SLECommentCell.m
//  百思不得姐
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLECommentCell.h"
#import "SLEComment.h"
#import "SLEUser.h"
#import <UIImageView+WebCache.h>





@interface SLECommentCell()


@property (weak, nonatomic) IBOutlet UILabel *like_countLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profile_imageImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation SLECommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.numberOfLines = 0;
    // Initialization code
}


- (void)setComment:(SLEComment *)comment
{
    
    _comment = comment;

    self.like_countLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];

    [self.profile_imageImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 将头像设置为圆形头像
        self.profile_imageImageView.image = [image sle_circleImage];
    }];
    
    // 用户昵称
    self.nameLabel.text = comment.user.username;
    
    // 评论内容
    self.contentLabel.text = comment.content;
    
    // 显示用户性别
    if ([comment.user.sex isEqualToString:@"f"])   self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
        
    if ([comment.user.sex isEqualToString:@"m"])   self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd",comment.voicetime] forState:UIControlStateNormal];
    }else{
    
        self.voiceButton.hidden = YES;
    }
    
    

}





@end
