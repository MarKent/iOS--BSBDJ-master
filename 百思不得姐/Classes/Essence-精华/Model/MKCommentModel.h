//
//  MKCommentModel.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/29.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKUserModel;

@interface MKCommentModel : NSObject

/** 评论内容 */
@property (nonatomic , copy)NSString *content;
/** 该评论的点赞数 */
@property (nonatomic , copy)NSString *like_count;
/** 用户 */
@property (nonatomic , strong)MKUserModel *user;

@end
