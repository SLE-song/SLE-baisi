//
//  SLEPublishController.m
//  百思不得姐
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEPublishController.h"
#import "SLEVerticalButton.h"
#import "SLEWordController.h"
#import "SLENavigationController.h"
#import "SLETabBarController.h"
#import <POP.h>

@interface SLEPublishController ()

@end

@implementation SLEPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    
    
}


- (void)setup
{

    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];

    NSInteger maxClo = 3;
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat startY = (SLEScreenH - buttonH * (maxClo - 1)) * 0.5;
    CGFloat startX = 30.0;
    CGFloat margin = (SLEScreenW - buttonW *maxClo - 2 *startX) / (maxClo - 1);
    NSInteger j = 5;
    
    for (int i =0; i < images.count; i++) {
        int row = i / maxClo;
        int col = i % maxClo;
        SLEVerticalButton *button = [[SLEVerticalButton alloc] init];
        button.tag = i;
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat buttonX = startX + (margin + buttonW) * col;
        CGFloat buttonY = startY + buttonH * row;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
        
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - SLEScreenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
//        anim.springBounciness = 15;
//        anim.springSpeed = 15;
        anim.beginTime = CACurrentMediaTime() + 0.1 *i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    // 设置标语
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];

    CGFloat centerX = SLEScreenW * 0.5;
    CGFloat endY = SLEScreenH * 0.15;
    CGFloat beginY = endY - SLEScreenH;
    imageView.sle_centerY = beginY;
    [self.view addSubview:imageView];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, beginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, endY)];
    anim.beginTime = CACurrentMediaTime() + 0.1 *j;
    [imageView pop_addAnimation:anim forKey:nil];
    
}

- (void)buttonClick:(UIButton *)button{
    
  [self cancleWithCompletionBlock:^{
     
      if (button.tag == 0) {
          
          SLELog(@"发视频");
      }if (button.tag == 1) {
          SLELog(@"发图片");
      }if (button.tag == 2) {
          
          SLEWordController *wordVc = [[SLEWordController alloc] init];
          
          SLETabBarController *rootVc = (SLETabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
          
          SLENavigationController *nav = [[SLENavigationController alloc] initWithRootViewController:wordVc];
          
          
          [rootVc presentViewController:nav animated:YES completion:nil];
          
          
      }if (button.tag == 3) {
          SLELog(@"发声音");
      }if (button.tag == 4) {
          SLELog(@"审帖");
      }if (button.tag == 5) {
          SLELog(@"发链接");
      }
      
  }];


}

- (void)cancleWithCompletionBlock:(void(^)())completionBlock{
    
    
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        
        CGFloat centerY = subView.sle_centerY + SLEScreenH;
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        //        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, beginY)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.sle_centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subView pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
//                completionBlock ? completionBlock() : nil;
                !completionBlock ? : completionBlock();
                
            }];
            
        }
    }

    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self cancleWithCompletionBlock:nil];


}




- (IBAction)cancell {
    
    [self cancleWithCompletionBlock:nil];
}

@end
