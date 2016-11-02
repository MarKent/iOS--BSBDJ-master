//
//  MKTopicCell.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/25.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKAllTopicsModel;

@interface MKTopicCell : UITableViewCell
/* 模型数据 */
@property (nonatomic , strong)MKAllTopicsModel *allTopicModel;
@end
