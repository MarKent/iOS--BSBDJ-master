//
//  MKRecommndModel.h
//  百思不得姐
//
//  Created by Mark Kent on 16/11/9.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKRecommndModel : NSObject

/** 头像URL */
@property (nonatomic , copy)NSString *image_list;
/** 昵称 */
@property (nonatomic , copy)NSString *theme_name;
/** 订阅量 */
@property (nonatomic , assign)NSInteger sub_number;

@end
