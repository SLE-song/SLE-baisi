//
//  SLETopicPictureView.h
//  百思不得姐
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLETopic;

@interface SLETopicPictureView : UIView
/** 模型 */
@property (strong ,nonatomic) SLETopic *topic;

+ (instancetype)sle_pictureView;

@end
