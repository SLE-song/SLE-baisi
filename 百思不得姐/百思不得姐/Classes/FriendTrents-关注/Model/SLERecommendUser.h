//
//  SLERecommendUser.h
//  百思不得姐
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLERecommendUser : NSObject

/* 用户头像 */
@property (strong ,nonatomic) NSString *header;

/* 关注用户的人数 */
@property (assign ,nonatomic) NSInteger fans_count;


/* 用户的昵称 */
@property (strong ,nonatomic) NSString *screen_name;



@end
