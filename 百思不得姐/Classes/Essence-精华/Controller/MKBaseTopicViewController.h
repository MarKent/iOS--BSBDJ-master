//
//  MKBaseTopicViewController.h
//  百思不得姐
//
//  Created by Mark Kent on 16/11/3.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKAllTopicsModel.h"

@interface MKBaseTopicViewController : UITableViewController


/** 等于get方法
 *请求数据的类型,如视频或者图片
   *声明此方法,保证只能其子类内部去更改类型的值,外部能调用
   *用属性定义的话,外界能够更改,且存在顺序问题,可能会得到空值
   *用只读属性的话会多生成一个_topicType成员变量
 @return MKTopicType
 */
- (MKTopicType)topicType;

@end
