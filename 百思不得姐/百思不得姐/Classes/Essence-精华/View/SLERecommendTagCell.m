//
//  SLERecommendTagCell.m
//  百思不得姐
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLERecommendTagCell.h"
#import <UIImageView+WebCache.h>
#import "SLERecommendTag.h"


@interface SLERecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *image_listImageView;

@property (weak, nonatomic) IBOutlet UILabel *theme_nameLabel;


@property (weak, nonatomic) IBOutlet UILabel *sub_numLabel;

@end



@implementation SLERecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setRecommendTag:(SLERecommendTag *)recommendTag
{
    // 保存模型
    _recommendTag = recommendTag;
    
    // 下载设置图片
    [self.image_listImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] sle_circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.image_listImageView.image = [image sle_circleImage];
        
    }];
    
    // 设置文字
    self.theme_nameLabel.text = recommendTag.theme_name;
    
    // 设置订阅人数显示格式
    NSString *sumNum = nil;
    if (recommendTag.sub_number <10000) {
        sumNum = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
        sumNum = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    // 显示订阅人数
    self.sub_numLabel.text = sumNum;
}


/*
 *  重新设置frame
 */
- (void)setFrame:(CGRect)frame
{

    frame.origin.x = 5;
    frame.size.width -= 2 *frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];

}







@end
