//
//  SLESquareButton.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLESquareButton.h"

@implementation SLESquareButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.sle_width = self.sle_width * 0.5;
    self.imageView.sle_y = self.sle_height * 0.15;
    self.imageView.sle_height = self.imageView.sle_width;
    self.imageView.sle_centerX = self.sle_width * 0.5;
    
    self.titleLabel.sle_x = 0;
    self.titleLabel.sle_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.sle_width = self.sle_width;
    self.titleLabel.sle_height = self.sle_height - self.titleLabel.sle_y;

}



@end
