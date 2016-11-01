//
//  SLETagField.m
//  百思不得姐
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETagField.h"

@implementation SLETagField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)deleteBackward
{

    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}


@end
