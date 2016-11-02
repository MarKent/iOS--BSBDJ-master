//
//  MKModelConfig.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/30.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKModelConfig.h"
#import <MJExtension.h>
#import "MKAllTopicsModel.h"
#import "MKCommentModel.h"

@implementation MKModelConfig

//只要这个类占有内存就会调用这个方法,可以在此配置model的一些属性转换
+ (void)load {

    //返回的数据中评论信息以一个字典形式放在在一个数组中
    //设置数组为一个模型的属性,下面的方法即将字典转为模型放入属性数组中
    [MKAllTopicsModel mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"top_cmt":[MKCommentModel class]};
    }];
    //该方法:转换某属性名获得相应的数据如解决关键字和属性名之间的冲突 属性-->映射<--数据key
    [MKAllTopicsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        //直接将返回的数组数据中的某个字典转换为模型
        return @{@"small_image":@"image0",
                 @"middle_image":@"image2",
                 @"large_image":@"image1"};
    }];
    /*
    //该方法:转换某属性名获得相应的数据如解决关键字和属性名之间的冲突 属性-->映射<--数据key
    [MKAllTopicsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        //直接将返回的数组数据中的某个字典转换为模型
        return @{@"top_cmt":@"top_cmt[0]"};
    }];
    //该方法:驼峰形式命名的属性于下划线形式的数据中的key的转换
    [MKAllTopicsModel mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        
        //假设模型中的属性以驼峰形式命名,数据中的key以下划线命名
        return [propertyName mj_underlineFromCamel];
    }];
     */
}

@end
