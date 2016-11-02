//
//  MKTopicPictureContentView.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/31.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKAllTopicsModel;
@class DALabeledCircularProgressView;

@interface MKTopicPictureContentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImage;

@property (nonatomic , strong)MKAllTopicsModel *topicModel;

@end
