//
//  MKAllTopicsModel.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/22.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//  精华All模块的数据模型

#import <Foundation/Foundation.h>
@class MKCommentModel;

typedef NS_OPTIONS(NSUInteger, MKTopicype) {

    /** 图片 */
    MKTopicTypePicture = 10,
    /** 段子 */
    MKTopicTypeWord = 29,
    /** 声音 */
    MKTopicTypeVoice = 31,
    /** 视频 */
    MKTopicTypeVideo = 41
    
};
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
/** 最热评论 */
@property (nonatomic , strong)NSArray *top_cmt;
/** 返回类型 */
@property (nonatomic , assign)MKTopicype type;
/** 返回的中间内容的宽 */
@property (nonatomic , assign)CGFloat width;
/** 返回的中间内容的高 */
@property (nonatomic , assign)CGFloat height;
/** 小图 */
@property (nonatomic , copy)NSString *small_image;
/** 中图 */
@property (nonatomic , copy)NSString *middle_image;
/** 大图 */
@property (nonatomic , copy)NSString *large_image;
/*** 是否是动态图片 ***/
@property (nonatomic , assign)BOOL is_gif;
/** 音频/视频播放次数 */
@property (nonatomic , assign)NSInteger playcount;
/** 音频时间 */
@property (nonatomic , assign)NSInteger viocetime;
/** 视频时间 */
@property (nonatomic , assign)NSInteger videotime;

/****************** 非请求数据 *******************/
/*** 是超长图片 ***/
@property (nonatomic , assign,getter=isLargeImage)BOOL largeImage;
/*****  计算后的整个单元格的高度  ****/
@property (nonatomic , assign)CGFloat cellHeight;
@property (nonatomic , assign)CGRect middleContentFrame;
@end
