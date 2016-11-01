//
//  SLETopicVideoView.h
//  
//
//  Created by apple on 16/7/30.
//
//

#import <UIKit/UIKit.h>

@class SLETopic;

@interface SLETopicVideoView : UIView
/** 模型 */
@property (strong ,nonatomic) SLETopic *topic;

+ (instancetype)sle_videoView;


@end
