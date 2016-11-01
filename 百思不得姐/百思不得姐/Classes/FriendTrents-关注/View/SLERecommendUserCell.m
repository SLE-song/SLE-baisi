//
//  SLERecommendUserCell.m
//  百思不得姐
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLERecommendUserCell.h"
#import "UIImageView+WebCache.h"
#import "SLERecommendUser.h"


@interface SLERecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@end




@implementation SLERecommendUserCell


- (void)setUsers:(SLERecommendUser *)users
{

    _users = users;
    
    self.userNameLabel.text = users.screen_name;
    
//    self.fansCount.text = [NSString stringWithFormat:@"%zd人关注",users.fans_count];
    
    NSString *fansNum = nil;
    if (users.fans_count <10000) {
        fansNum = [NSString stringWithFormat:@"%zd人关注",users.fans_count];
    }else{
        
        fansNum = [NSString stringWithFormat:@"%.1f万人关注",users.fans_count/10000.0];
        
    }
    
    self.fansCount.text = fansNum;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:users.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];


}












- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
