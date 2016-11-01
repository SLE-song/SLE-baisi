//
//  UIView+SLEExtention.h
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SLEExtention)

/* 自定义宽度 */
@property (assign ,nonatomic) CGFloat sle_width;
/* 自定义高度 */
@property (assign ,nonatomic) CGFloat sle_height;
/* 自定义x */
@property (assign ,nonatomic) CGFloat sle_x;
/* 自定义y */
@property (assign ,nonatomic) CGFloat sle_y;
/* 自定义size */
@property (assign ,nonatomic) CGSize sle_size;
/* 自定义centerX */
@property (assign ,nonatomic) CGFloat sle_centerX;
/* 自定义centerY */
@property (assign ,nonatomic) CGFloat sle_centerY;

// 判断一个空间是否在主窗口上
- (BOOL)sle_isShowingOnKeyWindow;

@end
