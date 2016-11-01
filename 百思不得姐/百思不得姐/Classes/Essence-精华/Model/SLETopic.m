//
//  SLETopic.m
//  百思不得姐
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETopic.h"
#import <MJExtension.h>
#import "SLEUser.h"
#import "SLEComment.h"



@implementation SLETopic

{

    CGFloat _cellHeight;

}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{

    return @{
    
             @"top_cmt" : @"SLEComment"
    };

}


- (NSString *)create_time
{
    // 时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    // 获取创建时间
    NSDate *creatDate = [formatter dateFromString:_create_time];

    if (creatDate.sle_isThisYear) {// 是今年创建的
        
        if (creatDate.sle_isToday) {// 今天创建
            
            NSDateComponents *components = [[NSDate date] sle_deltaFrom:creatDate];
            
            if (components.hour >= 1) {// 时间差距大于等于1小时
                
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
                
            } else if(components.minute >=1){
                
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else{
            
            return @"刚刚";
            }
            
            
        } else if(creatDate.sle_isYestorday){
            
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:creatDate];
            
        }else{
        
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:creatDate];
        
        }
        
    }else{// 不是今年创建的
    
        return _create_time;
    
    }



}


- (CGFloat)cellHeight
{
    
    if (!_cellHeight) {
        
        // 计算文字宽度
        CGSize maxSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 *SLETopicCellMargin, MAXFLOAT);
        
        // 计算文字高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // 计算cell高度
        _cellHeight = textH + SLETopicCellBottomH +SLETopicCellTextY + 2 *SLETopicCellMargin;
        
        if (self.type == SLETopicTypePicture) {
            
            if (self.width != 0 && self.height != 0) {
                CGFloat pictureW = maxSize.width;
                CGFloat pictureH = pictureW * self.height / self.width;
                
                if (pictureH >= SLETopicCellMaxH) { // 图片高度过长
                    pictureH = SLETopicCellPictureBreakH;
                    self.bigPicture = YES; // 大图
                }else{
                    self.bigPicture = NO; // 大图
                }
                
                CGFloat pictureX = SLETopicCellMargin;
                CGFloat pictureY = SLETopicCellTextY + SLETopicCellMargin + textH;
                _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                _cellHeight += pictureH + SLETopicCellMargin;

            }
            
        }if (self.type == SLETopicTypeVoice) {
            
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            CGFloat voiceX = SLETopicCellMargin;
            CGFloat voiceY = SLETopicCellTextY + SLETopicCellMargin + textH;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + SLETopicCellMargin;
            
        }if (self.type == SLETopicTypeVideo) {
            
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            CGFloat videoX = SLETopicCellMargin;
            CGFloat videoY = SLETopicCellTextY + SLETopicCellMargin + textH;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + SLETopicCellMargin;
            
        }
        
        /*
         *  最热评论
         */
        SLEComment *comment = [self.top_cmt firstObject];
        if (comment) {
            
            NSString *content = [NSString stringWithFormat:@"%@ : %@",comment.user.username, comment.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            
            
             _cellHeight += contentH + 25 +SLETopicCellMargin;
        }
    
    
    }
        
        return _cellHeight;
        
    
}


@end
