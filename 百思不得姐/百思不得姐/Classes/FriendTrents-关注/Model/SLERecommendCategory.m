//
//  SLERecommendCategory.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLERecommendCategory.h"
#import <MJExtension.h>


@implementation SLERecommendCategory

- (NSMutableArray *)users
{

    if (!_users) {
        
        _users = [NSMutableArray array];
        
    }

    return _users;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{

    return @{
             
             @"ID" : @"id"
             
             };


}



@end
