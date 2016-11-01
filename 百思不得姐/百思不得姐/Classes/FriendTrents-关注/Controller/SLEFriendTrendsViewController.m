//
//  SLEFriendTrendsViewController.m
//  百思不得姐
//
//  Created by apple on 16/7/17.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEFriendTrendsViewController.h"
#import "SLERecommendViewController.h"
#import "SLELoginRegisterController.h"



@interface SLEFriendTrendsViewController ()

@end

@implementation SLEFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sle_itemWithImage:@"friendsRecommentIcon" hightLImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    
    self.view.backgroundColor = SLEGlobalBg;
    
    

    
    
    
}

- (void)friendClick
{

    SLERecommendViewController *vc = [[SLERecommendViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    

}


- (IBAction)loginRegister:(id)sender {
    
    SLELoginRegisterController *loginRe = [[SLELoginRegisterController alloc] init];
    
    [self.navigationController presentViewController:loginRe animated:YES completion:nil];
    
}



@end
