//
//  NSDate+MKTimeHandle.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/28.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//  时间处理

#import <Foundation/Foundation.h>

@interface NSDate (MKTimeHandle)
/**
 是否是今年

 @return YES OR NO
 */
- (BOOL)isThisYear;
/**
 是否是今天
 
 @return YES OR NO
 */
- (BOOL)isToday;
/**
 是否是昨天
 
 @return YES OR NO
 */
- (BOOL)isYesterday;
/**
 是否是明天
 
 @return YES OR NO
 */
- (BOOL)isTomorrow;
@end
