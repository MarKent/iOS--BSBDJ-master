//
//  MKAllTopicsModel.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/22.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//  问题:1.不能在条件语句中先给_create_at赋值再return,否则数据为空
//      2.不能把第一次的fmt_.dateFormat写在initialize方法中,否则模型的get方法返回空


#import "MKAllTopicsModel.h"
#import "MKCommentModel.h"

@implementation MKAllTopicsModel

#pragma mark - 单元格高度
- (CGFloat)cellHeight {

    //如果已经计算过显示过的单元格高度,便不再调用该方法(懒加载)
    if (_cellHeight) return _cellHeight;
    
    //1.头像昵称部分
    _cellHeight = 40 + 2*MKMargin;
    //2.文字内容部分
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width-2*MKMargin;
    CGSize rectSize = CGSizeMake(contentW, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight += textSize.height + MKMargin;
    //3.中间内容 非纯段子的帖子情况下
    if (self.type != MKTopicTypeJoker) {
        
        CGFloat contentH = contentW * self.height / self.width;
        CGFloat contentX = MKMargin;
        CGFloat contentY = 40 + 2*MKMargin + textSize.height + MKMargin;
        if (contentH >= 450) {
            
            contentH = 300;
            self.largeImage = YES;
        }
        self.middleContentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        _cellHeight += contentH + MKMargin;
    }
    if (self.top_cmt.count) {
        MKCommentModel *cmtModel = self.top_cmt.firstObject;
        CGSize comTextSize = [cmtModel.content boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        _cellHeight += comTextSize.height + 20 + MKSmallMargin;
    }
    //4.底部+为了分组效果减去的10高度
    _cellHeight += 35 + MKMargin;
    
    return _cellHeight;
}

#pragma mark - 日期返回样式处理
//保证下面两个对象只创建一次
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;
+ (void)initialize {//使用这个类就只会调用一次这个方法

    fmt_ = [[NSDateFormatter alloc] init];
    
    calendar_ = [NSCalendar mk_calendar];
}
/**
 处理时间
 @return 处理后的时间,
 *今年:
 1.今天:刚刚,5分钟前,3小时前,
 2.昨天:昨天 10:20:50,
 3.其他:10月25日 10:50:20,
 *非今年:
 2015年9月20日 20:30:30

 */
- (NSString *)created_at {
    
    
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //将数据的日期字符串转换成NSDate格式
    NSDate *creatTimeDate = [fmt_ dateFromString:_created_at];
    //判断是否是今年
    if ([creatTimeDate isThisYear]) {//今年
        if ([creatTimeDate isToday]) {//今天
            //与当前日期比较
            NSDate *currentDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *comps = [calendar_ components:unit fromDate:creatTimeDate toDate:currentDate options:0];
            if (comps.hour >= 1) {//大于等于一小时
                return  [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute > 1) {//大于一分钟小于一小时
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else {
                return @"刚刚";
            }
        }else if ([creatTimeDate isYesterday]) {//昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:creatTimeDate];
        }else {//其他日期
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:creatTimeDate];
        }
    }else {//非今年
        fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt_ stringFromDate:creatTimeDate];
    }
}

@end
