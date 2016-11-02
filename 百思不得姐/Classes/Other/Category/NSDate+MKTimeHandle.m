//
//  NSDate+MKTimeHandle.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/28.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "NSDate+MKTimeHandle.h"

@implementation NSDate (MKTimeHandle)


/**
 是否是今年
 */
- (BOOL)isThisYear {
    //方法1
    //NSCalendar *calendar = [NSCalendar mk_calendar];
    //NSInteger selfDate = [calendar component:NSCalendarUnitYear fromDate:self];
    //NSInteger currentDate = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    //return selfDate == currentDate;
    
    //方法2
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy";
    return ([fmt stringFromDate:self] == [fmt stringFromDate:[NSDate date]]);
  
}
/**
 是否是今天
 */
- (BOOL)isToday {

    //方法1
    //NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyyMMdd";
    //return [[fmt stringFromDate:self] isEqualToString:[fmt stringFromDate:[NSDate date]]];
    
    //方法二
    NSCalendar *calendar = [NSCalendar mk_calendar];
    NSDateComponents *selfComps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *currentDateComps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    return selfComps.year == currentDateComps.year
    && selfComps.month == currentDateComps.month
    && selfComps.day == currentDateComps.day;
}
/**
 是否是昨天
 */
- (BOOL)isYesterday {
/*时分秒是干扰因素,要统一*/
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    //获得@"yyyyMMdd 00:00:00"类型的日期字符串
    NSString *selfStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    //转成yyyy-MM-dd 00:00:00日期 统一时分秒  只计算相差一天
    NSDate *newSelfDate = [fmt dateFromString:selfStr];
    NSDate *nowNewDate = [fmt dateFromString:nowStr];
    //计算相差的时间
    NSCalendar *calendar = [NSCalendar mk_calendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newSelfDate toDate:nowNewDate options:0];
    //返回是否相差一天
    return comps.year == 0
    &&comps.month == 0
    &&comps.day == 1;
}
/**
 是否是明天
 */
- (BOOL)isTomorrow {
/*时分秒是干扰因素,要统一*/
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    //获得@"yyyyMMdd 00:00:00"类型的日期字符串
    NSString *selfStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    //转成yyyy-MM-dd 00:00:00日期 统一时分秒  只计算相差一天
    NSDate *newSelfDate = [fmt dateFromString:selfStr];
    NSDate *nowNewDate = [fmt dateFromString:nowStr];
    //计算相差的时间
    NSCalendar *calendar = [NSCalendar mk_calendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newSelfDate toDate:nowNewDate options:0];
    //返回是否相差负一天
    return comps.year == 0
    &&comps.month == 0
    &&comps.day == -1;
}

@end
