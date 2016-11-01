//
//  SLEMeFooterView.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEMeFooterView.h"
#import "SLESquare.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "SLESquareButton.h"
#import "SLEMeWebController.h"

@implementation SLEMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *squares = [SLESquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            
            
            [self creatSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
        
    }

    return self;

}


- (void)creatSquares:(NSArray *)squares
{
    
    // 第一最大行数
    int maxCol = 4;
    CGFloat buttonW = SLEScreenW / maxCol;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        
        SLESquareButton *button = [SLESquareButton buttonWithType:UIButtonTypeCustom];
        
        SLESquare *square = squares[i];
        button.square = square;
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(butotnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        int row = i / maxCol;
        int col = i % maxCol;
        
        CGFloat buttonX = col * buttonW ;
        CGFloat buttonY = row * buttonH;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self addSubview:button];
        
    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (squares.count + maxCol - 1) / maxCol;
    
    // 计算footer的高度
    self.sle_height = rows * buttonH;
    
    // 重绘
    [self setNeedsDisplay];



}



- (void)butotnClick:(SLESquareButton *)button
{
    
    
    if (![button.square.url hasPrefix:@"http"]) return;
    SLEMeWebController *webController = [[SLEMeWebController alloc] init];
    webController.url = button.square.url;
    webController.title = button.square.name;
    
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
    
    [nav pushViewController:webController animated:YES];
    
    
}


@end
