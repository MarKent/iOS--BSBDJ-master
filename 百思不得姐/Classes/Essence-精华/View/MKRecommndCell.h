//
//  MKRecommndCell.h
//  百思不得姐
//
//  Created by Mark Kent on 16/11/9.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKRecommndModel;

@interface MKRecommndCell : UITableViewCell

/** 推荐标签模型 */
@property (nonatomic , strong)MKRecommndModel *recommndModel;

@end
