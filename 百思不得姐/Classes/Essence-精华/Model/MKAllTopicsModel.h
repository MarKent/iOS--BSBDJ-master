//
//  MKAllTopicsModel.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/22.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//  精华All模块的数据模型

#import <Foundation/Foundation.h>

@interface MKAllTopicsModel : NSObject
/** 头像url */
@property (nonatomic , copy)NSString *profile_image;
/** 昵称 */
@property (nonatomic , copy)NSString *name;
/** 文字内容 */
@property (nonatomic , copy)NSString *text;
/** 审核发布时间 */
@property (nonatomic , copy)NSString *created_at;
/** 赞数 */
@property (nonatomic , copy)NSString *ding;
/** 踩数 */
@property (nonatomic , copy)NSString *cai;
/** 转发数 */
@property (nonatomic , copy)NSString *repost;
/** 评论数 */
@property (nonatomic , copy)NSString *comment;
@end
