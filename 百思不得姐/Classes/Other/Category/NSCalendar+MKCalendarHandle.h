//
//  NSCalendar+MKCalendarHandle.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/28.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (MKCalendarHandle)


/**
 根据系统版本选择初始化方法

 @return NSCalendar *
 */
+ (instancetype)mk_calendar;

@end
