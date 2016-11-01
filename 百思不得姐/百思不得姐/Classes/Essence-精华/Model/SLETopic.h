//
//  SLETopic.h
//  百思不得姐
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLETopic : NSObject
/** id */
@property (copy ,nonatomic) NSString *ID;
/** 名称 */
@property (copy ,nonatomic) NSString *name;
/** 头像 */
@property (copy ,nonatomic) NSString *profile_image;
/** 发帖时间 */
@property (copy ,nonatomic) NSString *create_time;
/** 文字内容 */
@property (copy ,nonatomic) NSString *text;
/** 顶的数量 */
@property (assign ,nonatomic) NSInteger ding;
/** 踩的数量 */
@property (assign ,nonatomic) NSInteger cai;
/** 转发的数量 */
@property (assign ,nonatomic) NSInteger repost;
/** 评论的数量 */
@property (assign ,nonatomic) NSInteger comment;
/** 新浪加V用户 */
@property (assign ,nonatomic ,getter=isSina_v) BOOL sina_v;
/** 图片的高度 */
@property (assign ,nonatomic ,readonly) CGFloat height;
/** 图片的宽度 */
@property (assign ,nonatomic ,readonly) CGFloat width;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 播放次数 */
@property (assign ,nonatomic) NSInteger playcount;
/** 音乐时长 */
@property (assign ,nonatomic) NSInteger voicetime;
/** 视频时长 */
@property (assign ,nonatomic) NSInteger videotime;
/** 音频播放地址 */
@property (copy ,nonatomic) NSString *voiceuri;
/** 视频播放地址 */
@property (copy ,nonatomic) NSString *videouri;

/** 帖子的类型 */
@property (assign ,nonatomic) SLETopicType type;
/** gif图标是否隐藏 */
@property (assign ,nonatomic ,getter=isBigPicture) BOOL bigPicture;


/** 最热评论 */
@property (strong ,nonatomic) NSArray *top_cmt;




/*********************  额外的辅助属性 ***************************/
/** cell的高度 */
@property (assign ,nonatomic ,readonly) CGFloat cellHeight;
/** 图片的frame */
@property (assign ,nonatomic ,readonly) CGRect pictureFrame;
/** 声音的frame */
@property (assign ,nonatomic ,readonly) CGRect voiceFrame;
/** 视频的frame */
@property (assign ,nonatomic ,readonly) CGRect videoFrame;
/** 图片的下载进度 */
@property (assign ,nonatomic) CGFloat pictureProgress;


@end
