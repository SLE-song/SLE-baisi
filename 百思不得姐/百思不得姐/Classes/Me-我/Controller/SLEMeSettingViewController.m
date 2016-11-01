//
//  SLEMeSettingViewController.m
//  百思不得姐
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEMeSettingViewController.h"
#import <SDImageCache.h>

@interface SLEMeSettingViewController ()

@end

@implementation SLEMeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLEGlobalBg;
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    NSFileManager *manager = [NSFileManager defaultManager];
//    
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
//    
//    SLELog(@"%@",cachePath);
     CGFloat size = 0.0;
    
        
    size = [SDImageCache sharedImageCache].getSize;
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存:%.2fMB",size/ 1000.0 /1000];
    
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [[SDImageCache sharedImageCache] clearDisk];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存:0.00MB"];
    
}

@end
