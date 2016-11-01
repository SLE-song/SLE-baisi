//
//  SLETagButton.m
//  百思不得姐
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETagButton.h"

@implementation SLETagButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.sle_x = 5;
    self.imageView.sle_x = CGRectGetMaxX(self.titleLabel.frame) + 5;

}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = SLEColor(74, 139, 209);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.sle_width += 3 * 5;
}
@end
