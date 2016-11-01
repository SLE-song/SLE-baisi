//
//  SLEEssenceViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/17.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEEssenceViewController.h"
#import "SLESLERecommendTagViewController.h"
#import "SLETopicViewController.h"





@interface SLEEssenceViewController ()<UIScrollViewDelegate>

// 顶部条
@property (weak ,nonatomic) UIView *titleView;
// 顶部条指示器
@property (weak ,nonatomic) UIView *indicationView;
// 当前按钮
@property (weak ,nonatomic) UIButton *selectButton;
// uiscrollview
@property (weak ,nonatomic) UIScrollView *contentView;
@end

@implementation SLEEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置子控制器
    [self setupChildController];
    
    // 设置顶部内容
    [self setupTitles];
    
    // 设置scrollview
    [self setupContentView];
    
    
    
}

// 设置子控制器
- (void)setupChildController
{

    // 全部 控制器
    SLETopicViewController *allController = [[SLETopicViewController alloc] init];
    allController.type = SLETopicTypeAll;
    [self addChildViewController:allController];
    // 视频 控制器
    SLETopicViewController *videoController = [[SLETopicViewController alloc] init];
    videoController.type = SLETopicTypeVideo;
    [self addChildViewController:videoController];
    // 声音 控制器
    SLETopicViewController *voiceController = [[SLETopicViewController alloc] init];
    voiceController.type = SLETopicTypeVoice;
    [self addChildViewController:voiceController];
    // 图片 控制器
    SLETopicViewController *pictureController = [[SLETopicViewController alloc] init];
    pictureController.type = SLETopicTypePicture;
    [self addChildViewController:pictureController];
    // 段子 控制器
    SLETopicViewController *wordController = [[SLETopicViewController alloc] init];
    wordController.type = SLETopicTypeWord;
    [self addChildViewController:wordController];




}



// 设置导航栏
- (void)setupNav
{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sle_itemWithImage:@"MainTagSubIcon" hightLImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = SLEGlobalBg;



}


// 设置scrollview
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = [UIColor purpleColor];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.sle_width *self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    [self.view insertSubview:contentView atIndex:0];

    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}




// 设置顶部内容
- (void)setupTitles
{

    
    UIView *titleView = [[UIView alloc] init];
    titleView.sle_height = 45;
    titleView.sle_width = self.view.sle_width;
    titleView.sle_y = 64;
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 设置指示器
    UIView *indicationView = [[UIView alloc] init];
    indicationView.sle_height = 2;
    indicationView.sle_y = self.titleView.sle_height - indicationView.sle_height;
    indicationView.backgroundColor = [UIColor redColor];
    self.indicationView = indicationView;
    
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat width = self.titleView.sle_width / titles.count;
    
    for (NSInteger i =0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.sle_width = width;
        button.sle_x = i * width;
        button.sle_height = self.titleView.sle_height;
        [button addTarget:self action:@selector(titleViewClcik:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        [titleView addSubview:button];
        
        if (i == 0) {
            
            button.enabled = NO;
            self.selectButton = button;
            [button.titleLabel sizeToFit];
            indicationView.sle_width = button.titleLabel.sle_width;
            indicationView.sle_centerX = button.sle_centerX;
        }
        
    }
    
    [titleView addSubview:indicationView];
}


- (void)titleViewClcik:(UIButton *)button
{
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.indicationView.sle_width = button.titleLabel.sle_width;
        self.indicationView.sle_centerX = button.sle_centerX;
    }];

    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag *self.contentView.sle_width;
    [self.contentView setContentOffset:offset animated:YES];

}








// 点击左上角推荐标签按钮
- (void)tagClick
{

    SLESLERecommendTagViewController *tagViewContrller = [[SLESLERecommendTagViewController alloc] init];

    [self.navigationController pushViewController:tagViewContrller animated:YES];

}



#pragma mark -- <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.sle_width;
    UITableViewController *tabVc = self.childViewControllers[index];
    tabVc.view.sle_x = scrollView.contentOffset.x;
    tabVc.view.sle_y = 0;
    tabVc.view.sle_height = scrollView.sle_height;
    
    CGFloat bottom = self.tabBarController.tabBar.sle_height;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    tabVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    tabVc.tableView.scrollIndicatorInsets = tabVc.tableView.contentInset;
    [scrollView addSubview:tabVc.view];

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{


    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.sle_width;
    [self titleViewClcik:self.titleView.subviews[index]];







}


@end
