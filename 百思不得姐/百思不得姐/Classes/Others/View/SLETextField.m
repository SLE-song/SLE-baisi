//
//  SLETextField.m
//  百思不得姐
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETextField.h"

@implementation SLETextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{

    // 设置光标颜色
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];



}


// 当失去焦点时，设置占位文字颜色
- (BOOL)resignFirstResponder
{
    
    // 使用kvc设置占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];

}


// 当成为焦点时，设置占位文字颜色
- (BOOL)becomeFirstResponder
{
    
    // 使用kvc设置占位文字颜色
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super becomeFirstResponder];

}

@end
