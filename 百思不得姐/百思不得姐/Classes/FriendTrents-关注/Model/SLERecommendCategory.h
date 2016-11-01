//
//  SLERecommendCategory.h
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLERecommendCategory : NSObject

/* id */
@property (assign ,nonatomic) NSInteger ID;

/* 数量 */
@property (assign ,nonatomic) NSInteger count;

/* 名字 */
@property (strong ,nonatomic) NSString *name;

/* 用户数组 */
@property (strong ,nonatomic) NSMutableArray *users;


/* 当前页 */
@property (assign ,nonatomic) NSInteger currentPage;

/* 总页数 */
@property (assign ,nonatomic) NSInteger total;


@end
