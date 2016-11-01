//
//  SLEVerticalButton.m
//  百思不得姐
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEVerticalButton.h"

@implementation SLEVerticalButton


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    

}

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }

    return self;
}




- (void)layoutSubviews
{

    [super layoutSubviews];
    
    // 设置图片的位置
    self.imageView.sle_x = 0;
    self.imageView.sle_y = 0;
    self.imageView.sle_width = self.sle_width;
    self.imageView.sle_height = self.imageView.sle_width;
    
    // 设置label的位置
    self.titleLabel.sle_x = 0;
    self.titleLabel.sle_y = self.imageView.sle_height;
    self.titleLabel.sle_width = self.sle_width;
    self.titleLabel.sle_height = self.sle_height - self.titleLabel.sle_y;


}




@end
