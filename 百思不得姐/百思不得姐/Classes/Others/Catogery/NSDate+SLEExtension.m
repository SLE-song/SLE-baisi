//
//  NSDate+SLEExtension.m
//  百思不得姐
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "NSDate+SLEExtension.h"

@implementation NSDate (SLEExtension)

- (NSDateComponents *)sle_deltaFrom:(NSDate *)from
{

    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    return [calendar components:unit fromDate:from toDate:self options:0];

}


- (BOOL)sle_isThisYear{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;

}

- (BOOL)sle_isToday
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [formatter stringFromDate:[NSDate date]];
    NSString *selfString = [formatter stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
    
}

- (BOOL)sle_isYestorday
{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";

    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay |NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];

    return components.year == 0
    && components.month == 0
    && components.day == 1;
    
}

@end
