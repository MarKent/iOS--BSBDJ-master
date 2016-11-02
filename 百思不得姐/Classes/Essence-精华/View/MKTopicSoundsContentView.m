//
//  MKTopicSoundsContentView.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/31.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKTopicSoundsContentView.h"
#import "MKAllTopicsModel.h"
#import <UIImageView+WebCache.h>

@interface MKTopicSoundsContentView()
@property (weak, nonatomic) IBOutlet UIImageView *soundsImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;


@end
@implementation MKTopicSoundsContentView

- (void)setTopicModel:(MKAllTopicsModel *)topicModel {

    _topicModel = topicModel;
    
    //图片
    [self.soundsImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    if (topicModel.isLargeImage) {
        //如果是大图就切换图片显示样式
        self.soundsImageView.contentMode = UIViewContentModeScaleAspectFit;
    }else {
        
        self.soundsImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
    //时长
    NSInteger minute = topicModel.viocetime / 60;
    NSInteger second = topicModel.viocetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

- (IBAction)playVioce:(UIButton *)sender {
    MKLogFunc
}

@end
