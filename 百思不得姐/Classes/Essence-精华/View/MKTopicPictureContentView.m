//
//  MKTopicPictureContentView.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/31.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKTopicPictureContentView.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "MKAllTopicsModel.h"
#import <DALabeledCircularProgressView.h>

@implementation MKTopicPictureContentView

#pragma mark - 初始化
- (void)awakeFromNib {

    [super awakeFromNib];
    
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
}

- (void)setTopicModel:(MKAllTopicsModel *)topicModel {

    _topicModel = topicModel;
    
    //由于模拟器,直接显示一张图片
    [self.picture sd_setImageWithURL:[NSURL URLWithString:topicModel.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.placeholderImage.hidden = NO;
        //进度值计算
        CGFloat progress = 0.1 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        self.placeholderImage.hidden = YES;
    }];
    
    
    if (topicModel.isLargeImage) {
        //如果是大图就切换图片显示样式
        self.picture.contentMode = UIViewContentModeTop;
        self.picture.clipsToBounds = YES;
        
        //显示点击放大按钮
        self.seeBigImageBtn.hidden = NO;
    }else {
    
        self.picture.contentMode = UIViewContentModeScaleToFill;
        self.picture.clipsToBounds = YES;
        
        //隐藏点击放大按钮
        self.seeBigImageBtn.hidden = YES;
    }
    
    //是否是动态图
    self.gifImageView.hidden = !topicModel.is_gif;
    
    
    
    /*
    //判断是否是动态图,隐藏或显示gif图标
    //if ([topicModel.small_image.lowercaseString hasSuffix:@"gif"])//后缀判断
    if ([topicModel.small_image.pathExtension.lowercaseString isEqualToString:@"gif"])//扩展名判断
    {
        
        //先变小写,再判断后缀是否是.gif,如果是则隐藏gif图标
        self.gifImageView.hidden = NO;
    }else {
        self.gifImageView.hidden = YES;
        //不隐藏
    }*/
    /*
    //真机时判断网络状态,下载不同状态的图片
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {//手机自带网络
        
        [self.picture sd_setImageWithURL:[NSURL URLWithString:topicModel.small_image]];
    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {//无线网络
    
        [self.picture sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    }else {
    
        self.picture.image = nil;
    }
     */
}



- (IBAction)seeBigPicture {
    MKLogFunc
}

@end
