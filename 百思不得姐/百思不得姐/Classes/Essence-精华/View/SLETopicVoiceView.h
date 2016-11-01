//
//  SLETopicVoiceView.h
//  百思不得姐
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLETopic;

@interface SLETopicVoiceView : UIView
/** 模型 */
@property (strong ,nonatomic) SLETopic *topic;

+ (instancetype)sle_voiceView;


@end
