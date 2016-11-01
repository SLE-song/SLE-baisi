//
//  SLERecommendCell.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLERecommendCell.h"
#import "SLERecommendCategory.h"

@interface SLERecommendCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicater;


@end


@implementation SLERecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = SLEColor(244, 244, 244);
    self.selectedIndicater.backgroundColor = SLEColor(219, 21, 26);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicater.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicater.backgroundColor : SLEColor(78, 78, 78);
    
    
}

- (void)setCategory:(SLERecommendCategory *)category
{
    
    _category = category;

    
    self.textLabel.text = category.name;
}


- (void)layoutSubviews
{

    [super layoutSubviews];

    self.textLabel.sle_y = 2;
    self.textLabel.sle_height = self.contentView.sle_height - 2* self.textLabel.sle_y;

}

@end
