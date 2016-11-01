//
//  SLEAddTagController.h
//  百思不得姐
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLEAddTagController : UIViewController
/** 获取tag的block */
@property (copy ,nonatomic) void (^tagsBlock)(NSArray *);

/** 装标签文字的数组 */
@property (strong ,nonatomic) NSArray *tags;

@end
