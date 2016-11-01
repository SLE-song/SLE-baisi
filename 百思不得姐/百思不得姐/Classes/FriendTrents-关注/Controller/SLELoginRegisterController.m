//
//  SLELoginRegisterController.m
//  百思不得姐
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLELoginRegisterController.h"

@interface SLELoginRegisterController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end

@implementation SLELoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}





- (UIStatusBarStyle)preferredStatusBarStyle
{

    return UIStatusBarStyleLightContent;

}


- (IBAction)dimissBtn {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    
    [self.view endEditing:YES];

}

- (IBAction)loginRegisterBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.leftConstraint.constant = 0;
    }else if(!sender.selected){
        self.leftConstraint.constant = - self.view.sle_width;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
    
    
}

@end
