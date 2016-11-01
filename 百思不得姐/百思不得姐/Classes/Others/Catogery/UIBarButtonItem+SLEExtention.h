//
//  UIBarButtonItem+SLEExtention.h
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SLEExtention)

+ (instancetype)sle_itemWithImage:(NSString *)image hightLImage:(NSString *)hightLImage target:(id)target action:(SEL)action;

@end
