//
//  SLETopicCell.m
//  百思不得姐
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETopicCell.h"
#import "SLETopic.h"
#import <UIImageView+WebCache.h>
#import "SLETopicPictureView.h"
#import "SLETopicVoiceView.h"
#import "SLETopicVideoView.h"
#import "SLEComment.h"
#import "SLEUser.h"

@interface SLETopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** 帖子创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

/** 顶按钮 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

/** 踩按钮 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

/** 分享按钮 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

/** 评论按钮 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 新浪加V用户 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVImageView;

/** 中间帖子文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;



/** 图片模块中间图片 */
@property (weak ,nonatomic) SLETopicPictureView *pictureView;

/** 声音模块中间图片 */
@property (weak ,nonatomic) SLETopicVoiceView *voiceView;
/** 视频模块中间图片 */
@property (weak ,nonatomic) SLETopicVideoView *videoView;
/** 最热评论部分父控件 */
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
/** 最热评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@end


@implementation SLETopicCell

+ (instancetype)sle_topicCell
{

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;

}


// 懒加载
- (SLETopicPictureView *)pictureView
{
    if (!_pictureView) {
        SLETopicPictureView *pictureView = [SLETopicPictureView sle_pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        
    }


    return _pictureView;

}

// 懒加载
- (SLETopicVoiceView *)voiceView
{
    if (!_voiceView) {
        SLETopicVoiceView *voiceView = [SLETopicVoiceView sle_voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
        
    }
    
    
    return _voiceView;
    
}

// 懒加载
- (SLETopicVideoView *)videoView
{
    if (!_videoView) {
        SLETopicVideoView *videoView = [SLETopicVideoView sle_videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        
    }
    
    
    return _videoView;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    /*
     *  设置背景图片
     */
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    
}

- (void)setTopic:(SLETopic *)topic
{
    // 保存模型
    _topic = topic;
    
    // 如果是新浪v，就显示，如果不是，就隐藏新浪v
    self.sinaVImageView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 将头像设置为圆形头像
        self.profileImageView.image = [image sle_circleImage];
        
    }];
    self.nameLabel.text = topic.name;
    self.creatTimeLabel.text = topic.create_time;
    
    // 设置文字内容
    self.text_label.text = topic.text;
    // 设置四个按钮的文字，图片
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    if (topic.type == SLETopicTypePicture) {// 图片,隐藏其他部分
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureFrame;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }if (topic.type == SLETopicTypeVoice) {// 声音,隐藏其他部分
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }if (topic.type == SLETopicTypeVideo) {// 视频,隐藏其他部分
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }else if(topic.type == SLETopicTypeWord){// 段子,隐藏其他部分
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    
    
    }

    /*
     *  最热评论，如果有最热评论就显示，如果没有就隐藏
     */
    SLEComment *comment = [topic.top_cmt firstObject];
    if (comment) {// 如果有最热评论就显示
        self.topCommentView.hidden = NO;
        self.contentLabel.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username, comment.content];
    }else{// 如果没有就隐藏
    
        self.topCommentView.hidden = YES;
    
    }
    
    
}


/*
 *  设置按钮的 title  占位图片
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString*)placeholder
{

    if (count >10000) {
        
        placeholder = [NSString stringWithFormat:@"%.1f",count/1000.0];
        
    }else if (count >0){
    
        placeholder = [NSString stringWithFormat:@"%zd",count];
    
    }

    [button setTitle:placeholder forState:UIControlStateNormal];

}


// 重新设置frame
- (void)setFrame:(CGRect)frame
{
    
//    frame.origin.x = SLETopicCellMargin;
//    frame.size.width -= 2 * SLETopicCellMargin;
//    frame.size.height -= SLETopicCellMargin;
    frame.size.height =self.topic.cellHeight - SLETopicCellMargin;
    frame.origin.y += SLETopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more:(id)sender {
    
    /*
     *  弹出收藏。举报选项
     */
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
}



@end
