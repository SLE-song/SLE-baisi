//
//  UIBarButtonItem+SLEExtention.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "UIBarButtonItem+SLEExtention.h"

@implementation UIBarButtonItem (SLEExtention)

+ (instancetype)sle_itemWithImage:(NSString *)image hightLImage:(NSString *)hightLImage target:(id)target action:(SEL)action
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightLImage] forState:UIControlStateHighlighted];
    button.sle_size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[self alloc] initWithCustomView:button];
    
}

@end
