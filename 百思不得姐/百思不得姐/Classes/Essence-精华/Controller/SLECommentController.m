//
//  SLECommentController.m
//  百思不得姐
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLECommentController.h"
#import "SLETopicCell.h"
#import "SLETopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "SLEComment.h"
#import <MJExtension.h>
#import "SLECommentCell.h"


@interface SLECommentController ()<UITableViewDelegate ,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论 */
@property (strong ,nonatomic) NSArray *hotComments;
/** 保存最热评论 */
@property (strong ,nonatomic) NSArray *save_hotComments;
/** 最新评论 */
@property (strong ,nonatomic) NSMutableArray *latestComments;
/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation SLECommentController


static NSString *const ID = @"comment";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTitleAndNoti];
    
    [self setupHeader];
    [self setupRefreh];
}

- (NSMutableArray *)latestComments
{
    if (_latestComments == nil) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}


- (void)setupHeader
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.backgroundColor = SLEGlobalBg;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLECommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    // 创建header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = SLEGlobalBg;
    
    if (self.topic.top_cmt.count) {
        
        self.save_hotComments = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
        
    }
    // 添加cell
    SLETopicCell *cell = [SLETopicCell sle_topicCell];
    cell.topic = self.topic;
    cell.sle_size = CGSizeMake(SLEScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    //    header.backgroundColor = [UIColor redColor];
    // header的高度
    header.sle_height = self.topic.cellHeight + 2 *SLETopicCellMargin;
    
    // 设置header
    self.tableView.tableHeaderView = header;


}

- (void)setupTitleAndNoti
{
    self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem sle_itemWithImage:@"comment_nav_item_share_icon" hightLImage:@"comment_nav_item_share_icon_click" target:self action:@selector(more)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)more{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];


}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    self.bottomSpace.constant = SLEScreenH - frame.origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        [self.view layoutIfNeeded];
        
    }];

}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.save_hotComments.count) {
        
        self.topic.top_cmt = self.save_hotComments;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }

    [self.manager invalidateSessionCancelingTasks:YES];
}

- (void)setupRefreh
{

    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
//    self.tableView.mj_footer.hidden = YES;

}



- (void)loadMoreComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    SLEComment *comment = [self.latestComments lastObject];
    params[@"lastcid"] = comment.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
            
        }
        // 最新评论
        NSArray *newComments = [SLEComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        
        // 页码
        self.page = page;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}

- (void)loadNewComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @"1";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self.tableView.mj_header endRefreshing];
            return;
            
        }
        
        // 获取最热评论数据
        self.hotComments = [SLEComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 获取最新评论数据
        self.latestComments = [SLEComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 页码
        self.page = 1;
        // 刷新表格
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 停止刷新
        [self.tableView.mj_header endRefreshing];
    }];
    



}


// 获得当前组对应的数据
- (NSArray *)commentsInSection:(NSInteger)section
{

    if (section == 0) return self.hotComments.count ? self.hotComments : self.latestComments;
    return self.latestComments;

}

// 获得当前组对应的模型数据
- (SLEComment *)commentsInIndexPath:(NSIndexPath *)indexPath
{

    return [self commentsInSection:indexPath.section][indexPath.row];


}


#pragma mark ---<UITableViewDelegate>
// 当拖拽cell时 ，退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];
    
}



#pragma mark ---<UITableViewDataSource>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SLECommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
   
    // 取出模型
    cell.comment = [self commentsInIndexPath:indexPath];
    
    // 设置文字
//    cell.textLabel.text = comment.content;
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount)       return 2;
    if (latestCount)    return 1;
                        return 0;
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (section == 0) return hotCount ? hotCount :latestCount;
    
    return latestCount;
    

}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    NSInteger hotCount = self.hotComments.count;
//    
//    if (section == 0) return hotCount ? @"最热评论" : @"最新评论";
//    return @"最新评论";
//
//}



/*
 *  如果有多组数据，要考虑循环利用的情况
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 创建头部
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = SLEGlobalBg;
    
    // 创建label
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    label.textColor = SLEColor(67, 67, 67);
    label.sle_width = 200;
    label.sle_x = SLETopicCellMargin;
    [view addSubview:label];
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        
        label.text = hotCount ? @"最热评论" : @"最新评论";
    }else {
    
        label.text = @"最新评论";
    }
    
    
    return view;
}



@end
