//
//  SLENewViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/17.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLENewViewController.h"

@interface SLENewViewController ()

@end

@implementation SLENewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sle_itemWithImage:@"MainTagSubIcon" hightLImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = SLEGlobalBg;
    
//
//    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
//    tagButton.sle_size = tagButton.currentBackgroundImage.size;
//    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
//
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
    
}


- (void)tagClick
{
    
    SLELog(@"%s",__func__);
    
    
}





@end
