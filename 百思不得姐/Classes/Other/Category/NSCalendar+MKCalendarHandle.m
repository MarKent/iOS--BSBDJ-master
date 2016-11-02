//
//  NSCalendar+MKCalendarHandle.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/28.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "NSCalendar+MKCalendarHandle.h"

@implementation NSCalendar (MKCalendarHandle)


/**
 根据版本选择初始化方法
 */
+ (instancetype)mk_calendar {

    
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
    
        return [NSCalendar currentCalendar];
    }
}

@end
