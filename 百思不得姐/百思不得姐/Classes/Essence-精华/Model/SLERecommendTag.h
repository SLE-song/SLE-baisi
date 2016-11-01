//
//  SLERecommendTag.h
//  百思不得姐
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLERecommendTag : NSObject

/* 图片 */
@property (strong ,nonatomic) NSString *image_list;
/* 名字 */
@property (strong ,nonatomic) NSString *theme_name;

/* 订阅数 */
@property (assign ,nonatomic) NSInteger sub_number;

@end
