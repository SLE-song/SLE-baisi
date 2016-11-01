//
//  SLEMeCell.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEMeCell.h"

@implementation SLEMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = imageView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }


    return self;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    self.imageView.sle_width = 35;
    self.imageView.sle_height = self.imageView.sle_width;
    self.imageView.sle_centerY = self.contentView.sle_height *0.5;
    
    self.textLabel.sle_x = CGRectGetMaxX(self.imageView.frame) + SLETopicCellMargin;
}


@end
