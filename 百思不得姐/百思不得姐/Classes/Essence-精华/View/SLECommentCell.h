//
//  SLECommentCell.h
//  百思不得姐
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLEComment;
@interface SLECommentCell : UITableViewCell

/** 评论模型 */
@property (strong ,nonatomic) SLEComment *comment;

@end
