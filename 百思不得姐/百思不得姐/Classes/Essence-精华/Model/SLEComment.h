//
//  SLEComment.h
//  百思不得姐
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLEUser;
@interface SLEComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频时长 */
@property (assign ,nonatomic) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论文字内容 */
@property (copy ,nonatomic) NSString *content;
/** 被点赞的数量 */
@property (assign ,nonatomic) NSInteger like_count;

/** 用户 */
@property (strong ,nonatomic) SLEUser *user;
@end
