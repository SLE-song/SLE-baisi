//
//  SLESLERecommendTagViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLESLERecommendTagViewController.h"
#import "SLERecommendTag.h"
#import "SLERecommendTagCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>


@interface SLESLERecommendTagViewController ()

/* 数据 */
@property (strong ,nonatomic) NSMutableArray *recommendTag;

@end

@implementation SLESLERecommendTagViewController

static NSString  *const recommendTagID = @"recommendTag";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
    
}


-(void)setupTableView
{
    self.navigationItem.title = @"推荐标签";
    self.tableView.backgroundColor = SLEGlobalBg;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLERecommendTagCell class]) bundle:nil] forCellReuseIdentifier:recommendTagID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadTags
{

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.recommendTag = [SLERecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        
    }];

}




#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommendTag.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SLERecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTagID];
    
    cell.recommendTag = self.recommendTag[indexPath.row];
    
    return cell;
}


@end
