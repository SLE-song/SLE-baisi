//
//  SLETabBarController.m
//  百思不得姐
//
//  Created by apple on 16/7/17.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETabBarController.h"
#import "SLEEssenceViewController.h"
#import "SLEFriendTrendsViewController.h"
#import "SLEMeViewController.h"
#import "SLENewViewController.h"
#import "SLETabBar.h"

#import "SLENavigationController.h"



@interface SLETabBarController ()

@end

@implementation SLETabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置正常状态字体颜色
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 设置选中状态字体颜色
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    selectAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 取得所有上面的控件
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
    
    
    // 添加所有子控制器
    [self setupAllChildControllers];
    
    
    // 替换tabBar
    [self setValue:[[SLETabBar alloc] init] forKey:@"tabBar"];
    // 设置背景图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
    
}


// 添加所有子控制器
- (void)setupAllChildControllers
{

    // 精华
    [self setupOneChildController:[[SLEEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    // 新帖
    [self setupOneChildController:[[SLENewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    // 关注
    [self setupOneChildController:[[SLEFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    // 我
    [self setupOneChildController:[[SLEMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    
    


}


// 添加一个子控制器
- (void)setupOneChildController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{

    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    UIImage *tmpimage = [UIImage imageNamed:selectImage];
    tmpimage = [tmpimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = tmpimage;
    
    SLENavigationController *nav = [[SLENavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}




@end
