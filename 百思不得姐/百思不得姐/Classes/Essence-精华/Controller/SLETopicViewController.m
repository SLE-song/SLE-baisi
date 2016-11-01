//
//  SLETopicViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "SLETopic.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "SLETopicCell.h"
#import "SLECommentController.h"
#import "SLENewViewController.h"


@interface SLETopicViewController()

/* 所有请求的数据 */
@property (strong ,nonatomic) NSMutableArray *topics;
/* 请求的参数 */
@property (strong ,nonatomic) NSMutableDictionary *params;
/** 加载下一页的数据需要的参数 */
@property (copy ,nonatomic) NSString *maxtime;
/** 当前页 */
@property (assign ,nonatomic) NSInteger page;
/** 上次被选中控制器的索引 */
@property (assign ,nonatomic) NSInteger lastSelectedIndex;


@end

@implementation SLETopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
    
}



static NSString * const ID = @"topic";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLETopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    // 监听tabBar被点击两次
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(seletedTabBarController) name:SLETabBarControllerDidSelectedKey object:nil];
    
    [self setupRefresh];
    
}

- (void)setupRefresh
{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    
}


- (void)seletedTabBarController
{
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.sle_isShowingOnKeyWindow) {
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[SLENewViewController class]] ? @"newlist" : @"list";

    
   
    
}

- (void)loadNewTopics{
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) return ;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [SLETopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (self.params != params) return ;
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    
}

- (void)loadMoreTopics{
    
    [self.tableView.mj_header endRefreshing];
    self.page++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page +1;
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) return ;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newTopics = [SLETopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (self.params != params) return ;
        [self.tableView.mj_footer endRefreshing];
        
        
    }];
    
}






#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SLETopicCell *cell  =[tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLETopic *topic = self.topics[indexPath.row];
    
    
    
    return topic.cellHeight;
    
}



#pragma mark - Table view dele gate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SLECommentController *comment = [[SLECommentController alloc] init];
    
    comment.topic = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:comment animated:YES];

}


@end
