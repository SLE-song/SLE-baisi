//
//  SLERecommendViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLERecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "SLERecommendCategory.h"
#import "SLERecommendCell.h"
#import "SLERecommendUser.h"
#import "SLERecommendUserCell.h"
#import <MJRefresh.h>


@interface SLERecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

/* 左侧分类数组 */
@property (strong ,nonatomic) NSArray *catetories;
/* 右侧用户数组 */
//@property (strong ,nonatomic) NSArray *users;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/* AFN请求管理者 */
@property (strong ,nonatomic) AFHTTPSessionManager *manager;

/* 请求参数 */
@property (strong ,nonatomic) NSMutableDictionary *parameter;

@end


#define SLESelectedCategory self.catetories[self.categoryTableView.indexPathForSelectedRow.row]



@implementation SLERecommendViewController




static NSString *categoryID = @"category";
static NSString *userID = @"user";




/**
 *  懒加载
 */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        
        _manager = [AFHTTPSessionManager manager];
        
    }


    return _manager;

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];

    [self loaddata];
    [self setupRefresh];
    
    
    
}


// 初始化
- (void)setup
{
    
    self.view.backgroundColor = SLEGlobalBg;
    self.navigationItem.title = @"推荐关注";
    
    // 注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLERecommendCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLERecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
}


// 加载初始化数据
- (void)loaddata
{

    // 设置蒙板
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 获取数据
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"category";
    parameter[@"c"] = @"subscribe";
    
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 取消蒙板
        [SVProgressHUD dismiss];
        
        self.catetories = [SLERecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新数据
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 提示加载失败
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    
    }];
    



}


// 刷新
- (void)setupRefresh
{

    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

}


// 加载新数据
- (void)loadNew
{
    
    SLERecommendCategory *category = SLESelectedCategory;
    
    category.currentPage = 1;
    // 获取数据
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"list";
    parameter[@"c"] = @"subscribe";
    parameter[@"category_id"] = @(category.ID);
    parameter[@"page"] = @(category.currentPage);
    
    self.parameter = parameter;
    
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [SLERecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [category.users removeAllObjects];
        [category.users addObjectsFromArray:users];
        category.total = [responseObject[@"total"] integerValue];
        
        if (self.parameter != parameter)  return ;
        
        [self.userTableView reloadData];
        
        self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        
        
        [self.userTableView.mj_header endRefreshing];
        [self checkFooterState];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        if (self.parameter != parameter)  return ;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_header endRefreshing];
        
    }];

}

// 加载更多数据
- (void)loadMore
{

    SLERecommendCategory *category = SLESelectedCategory;
    
    
    // 设置请求参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"list";
    parameter[@"c"] = @"subscribe";
    parameter[@"category_id"] = @(category.ID);
    parameter[@"page"] = @(++category.currentPage);
    self.parameter = parameter;
    
    // 请求数据
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 将请求的数据存到数组
        NSArray *users = [SLERecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到分类用户数组
        [category.users addObjectsFromArray:users];
        
        // 如果请求的参数跟上次的不一样直接返回
        if (self.parameter != parameter)  return ;
        
        // 刷新表格
        [self.userTableView reloadData];
        
        // 判断自己footer 的状态，避免不能再次刷新
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];



}




// 判断
- (void)checkFooterState
{
    
    // 获取对应行的分类数据
    SLERecommendCategory *category = SLESelectedCategory;
    
    // 如果分类的用户数据为空，则不显示下拉刷新
    self.userTableView.mj_footer.hidden = (category.users.count == 0);

    // 如果用户的数量与请求的总数相等，则提示没有更多数据，否则结束此次刷新
    if (category.users.count == category.total) {
        
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        [self.userTableView.mj_footer endRefreshing];
        
    }


}





#pragma mark   <UITableViewDataSource>--数据源方法--

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // 判断显示分组数量
    if (tableView == self.categoryTableView)  return self.catetories.count;
        
        [self checkFooterState];
        
        SLERecommendCategory *category = SLESelectedCategory;
    
    return category.users.count;
    
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 判断显示那种cell
    if (tableView == self.categoryTableView) {
        
        SLERecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        
        cell.category = self.catetories[indexPath.row];
        
        return cell;
        
    }else{
    
        SLERecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        SLERecommendCategory *category = SLESelectedCategory;
        
        cell.users = category.users[indexPath.row];
        
        return cell;
    
    }

}







#pragma mark <UITableViewDelegate>--代理方法---

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 为了避免显示其他分类的数据，选中其他表格结束所有的刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    
    SLERecommendCategory *category = self.catetories[indexPath.row];
    
    category.currentPage = 1;
    
    if (category.users.count) {
        [self.userTableView reloadData];
    }else{
        
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
    }
        
    


}


// 控制器被销毁，取消所有的请求
- (void)dealloc
{

    [self.manager.operationQueue cancelAllOperations];

}





@end
