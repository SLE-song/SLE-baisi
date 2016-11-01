//
//  SLEMeViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/17.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEMeViewController.h"
#import "SLEMeCell.h"
#import "SLEMeFooterView.h"
#import "SLEMeSettingViewController.h"

@interface SLEMeViewController ()

@end

@implementation SLEMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    
    UIBarButtonItem *moonItem = [UIBarButtonItem sle_itemWithImage:@"mine-moon-icon" hightLImage:@"mine-sun-icon" target:self action:@selector(moonClick)];
    
    UIBarButtonItem *setItem = [UIBarButtonItem sle_itemWithImage:@"mine-setting-icon" hightLImage:@"mine-setting-icon-click" target:self action:@selector(setClick)];
    
    self.navigationItem.rightBarButtonItems = @[setItem ,moonItem];
    
    self.view.backgroundColor = SLEGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SLEMeCell class] forCellReuseIdentifier:SLEMeCellID];
    
    
    
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SLETopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(SLETopicCellMargin - 35, 0, 0, 0);
    self.tableView.tableFooterView = [[SLEMeFooterView alloc] init];
    
    
}

- (void)moonClick
{

    SLELogFunc;
}


- (void)setClick
{
    
    SLEMeSettingViewController *settingVc = [[SLEMeSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}


static NSString *const SLEMeCellID = @"me";

#pragma mark ---- <UITableViewDatasource>-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SLEMeCell *cell = [tableView dequeueReusableCellWithIdentifier:SLEMeCellID];
  

    if (indexPath.section == 0) {
        cell.textLabel.text = @"登陆/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}


#pragma mark ---- <UITableViewDelegate>

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    SLEMeFooterView *footerView = [[SLEMeFooterView alloc] init];
//
//
//
//    return footerView;
//}






@end
