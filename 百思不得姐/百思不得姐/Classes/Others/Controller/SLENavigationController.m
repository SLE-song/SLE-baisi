//
//  SLENavigationController.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLENavigationController.h"

@implementation SLENavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // 如果左滑失效，就设置代理为空，让控制器重新设置这个功能
    self.interactivePopGestureRecognizer.delegate = nil;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }


    [super pushViewController:viewController animated:animated];


}




- (void)back{


    [self popViewControllerAnimated:YES];


}
















@end
