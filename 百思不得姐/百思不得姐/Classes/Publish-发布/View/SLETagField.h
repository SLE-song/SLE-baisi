//
//  SLETagField.h
//  百思不得姐
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLETagField : UITextField

/** 点击删除键回调用的block */
@property (copy ,nonatomic) void (^deleteBlock)();

@end
