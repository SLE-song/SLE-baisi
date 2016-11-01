//
//  NSDate+SLEExtension.h
//  百思不得姐
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SLEExtension)


/*
 *  比较from和self的时间差值
 */
- (NSDateComponents *)sle_deltaFrom:(NSDate*)from;

/*
 *  判断是不是今年
 */
- (BOOL)sle_isThisYear;
/*
 *  判断是不是今天
 */
- (BOOL)sle_isToday;
/*
 *  判断是不是昨天
 */
- (BOOL)sle_isYestorday;





@end
