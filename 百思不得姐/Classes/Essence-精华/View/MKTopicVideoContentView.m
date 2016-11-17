//
//  MKTopicVideoContentView.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/31.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKTopicVideoContentView.h"
#import "MKAllTopicsModel.h"
#import <UIImageView+WebCache.h>
#import "MKSeeBigPictureViewController.h"

@interface MKTopicVideoContentView()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;


@end
@implementation MKTopicVideoContentView
#pragma mark - 初始化
-(void)awakeFromNib {

    [super awakeFromNib];
    
    //给图片添加点击手势
    self.videoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [self.videoImageView addGestureRecognizer:tap];
}
- (void)seeBigPicture {

    MKSeeBigPictureViewController *seeBigVc = [[MKSeeBigPictureViewController alloc] init];
    seeBigVc.topicModel = self.topicModel;
    //[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVc animated:YES completion:NULL];
    [self.window.rootViewController presentViewController:seeBigVc animated:YES completion:NULL];
}
#pragma mark - 赋值
- (void)setTopicModel:(MKAllTopicsModel *)topicModel {

    _topicModel = topicModel;
    
    //图片
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    if (topicModel.isLargeImage) {
        //如果是大图就切换图片显示样式
        self.videoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }else {
        
        self.videoImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
    //时长
    NSInteger minute = topicModel.videotime / 60;
    NSInteger second = topicModel.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
#pragma mark - 事件监听
- (IBAction)playVideo:(UIButton *)sender {
    MKLogFunc
}

@end
