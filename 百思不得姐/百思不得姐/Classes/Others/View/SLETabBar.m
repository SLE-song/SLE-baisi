//
//  SLETabBar.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETabBar.h"
#import "SLEPublishController.h"

@interface SLETabBar()

/*
 *  发布按钮
 */
@property (weak ,nonatomic) UIButton *publishButton;

@end



@implementation SLETabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加中间发布按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置图片
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        // 监听发布按钮的点击
        [button addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加按钮
        [self addSubview:button];
        self.publishButton = button;
        
    }
    

    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];

    // 设置发布按钮位置、尺寸
    self.publishButton.frame = CGRectMake(0, 0, self.publishButton.currentImage.size.width, self.publishButton.currentImage.size.height);
//    self.publishButton.center = CGPointMake(self.frame.size.width *0.5, self.frame.size.height *0.5);
    self.publishButton.center = CGPointMake(self.sle_width *0.5, self.sle_height *0.5);
    
    // 自定义其他tabBar的位置，预留发布按钮的位置
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
//    CGFloat buttonW = self.frame.size.width / 5;
//    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.sle_width / 5;
    CGFloat buttonH = self.sle_height;
    NSInteger index = 0;
    
    // 遍历所有子控件
    for (UIView *button in self.subviews) {
        
        // 如果不是UITabBarButton类型，直接跳过本次循环，开始下次循环
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        if (index == 2) {
            index += 1;
        }
        buttonX = buttonW *index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
        
    }
    
    
}


// 监听按钮的点击
- (void)publishButtonClick{

    SLEPublishController *publish = [[SLEPublishController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];

}


@end
