//
//  SLETopicCell.h
//  百思不得姐
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLETopic;
@interface SLETopicCell : UITableViewCell
/** 模型 */
@property (strong ,nonatomic) SLETopic *topic;

+ (instancetype)sle_topicCell;

@end
