//
//  MKTopicCell.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/25.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKTopicCell.h"
#import "MKAllTopicsModel.h"
#import "MKCommentModel.h"
#import "MKUserModel.h"
#import <UIImageView+WebCache.h>
#import "MKLoginViewController.h"
#import "MKTopicPictureContentView.h"
#import "MKTopicSoundsContentView.h"
#import "MKTopicVideoContentView.h"

@interface MKTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//昵称
@property (weak, nonatomic) IBOutlet UILabel *creatTime;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *text_label;//发布文本内容

@property (weak, nonatomic) IBOutlet UIView *hotCommentView;//热门评论视图
@property (weak, nonatomic) IBOutlet UILabel *hotCommentLabel;//热门评论内容
@property (weak, nonatomic) IBOutlet UILabel *hotCmtCountLabel;//热门评论被赞数

@property (weak, nonatomic) IBOutlet UIButton *dingButton;//顶按钮
@property (weak, nonatomic) IBOutlet UIButton *caiButton;//踩按钮
@property (weak, nonatomic) IBOutlet UIButton *shareButton;//分享按钮
@property (weak, nonatomic) IBOutlet UIButton *commentButton;//评论按钮

@property (nonatomic , strong)MKTopicPictureContentView *topicPictureView;
@property (nonatomic , strong)MKTopicSoundsContentView *topicSoundsView;
@property (nonatomic , strong)MKTopicVideoContentView *topicVideoView;

@end
@implementation MKTopicCell
#pragma mark - 懒加载
- (MKTopicPictureContentView *)topicPictureView {

    if (!_topicPictureView) {
        
        _topicPictureView = [MKTopicPictureContentView mk_viewFromXib];
        [self.contentView addSubview:_topicPictureView];
    }
    return _topicPictureView;
}
- (MKTopicSoundsContentView *)topicSoundsView {

    if (!_topicSoundsView) {
        
        _topicSoundsView = [MKTopicSoundsContentView mk_viewFromXib];
        [self.contentView addSubview:_topicSoundsView];
    }
    return _topicSoundsView;
}
- (MKTopicVideoContentView *)topicVideoView {

    if (!_topicVideoView) {
        
        _topicVideoView = [MKTopicVideoContentView mk_viewFromXib];
        [self.contentView addSubview:_topicVideoView];
    }
    return _topicVideoView;
}
#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    //单元格背景
    self.backgroundView = [[UIImageView alloc] initWithImage:MKImageName(@"mainCellBackground")];
}
- (void)setAllTopicModel:(MKAllTopicsModel *)allTopicModel {

    _allTopicModel = allTopicModel;
    
    //赋值
    UIImage *placeholderImage = [UIImage mk_circleImageWithName:@"defaultUserIcon"];
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:self.allTopicModel.profile_image] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.profileImage.image = [image mk_circleImage];
    }];
    self.nameLabel.text = allTopicModel.name;
    self.creatTime.text = allTopicModel.created_at;
    self.text_label.text = allTopicModel.text;
    //重新设置数字
    [self setButton:self.dingButton title:allTopicModel.ding placeholder:@"顶"];
    [self setButton:self.caiButton title:allTopicModel.cai placeholder:@"踩"];
    [self setButton:self.shareButton title:allTopicModel.repost placeholder:@"分享"];
    [self setButton:self.commentButton title:allTopicModel.comment placeholder:@"评论"];
    
    //是否有最热评论
    MKCommentModel *topCmtModel = allTopicModel.top_cmt.firstObject;
    
    if (allTopicModel.top_cmt.count) {
        self.hotCommentView.hidden = NO;
        self.hotCommentLabel.text = [NSString stringWithFormat:@"%@: %@",topCmtModel.user.username,topCmtModel.content];
        self.hotCmtCountLabel.text = [NSString stringWithFormat:@"%@人赞过",topCmtModel.like_count];
    }else {
    
        self.hotCommentView.hidden = YES;
    }
    
    //根据类型加载中间内容
    if (allTopicModel.type == MKTopicTypePicture) {//图片
        self.topicPictureView.hidden = NO;
        self.topicPictureView.frame = allTopicModel.middleContentFrame;
        self.topicPictureView.topicModel = allTopicModel;
        self.topicSoundsView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }else if (allTopicModel.type == MKTopicTypeVoice){//声音
        self.topicSoundsView.hidden = NO;
        self.topicSoundsView.frame = allTopicModel.middleContentFrame;
        self.topicSoundsView.topicModel = allTopicModel;
        self.topicPictureView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }else if (allTopicModel.type == MKTopicTypeVideo) {//视频
        self.topicVideoView.hidden = NO;
        self.topicVideoView.frame = allTopicModel.middleContentFrame;
        self.topicVideoView.topicModel = allTopicModel;
        self.topicPictureView.hidden = YES;
        self.topicSoundsView.hidden = YES;
    }else if (allTopicModel.type == MKTopicTypeJoker){//段子
    
        self.topicPictureView.hidden = YES;
        self.topicSoundsView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }
    //MKLog(@"%zd",allTopicModel.type);
}
#pragma mark - 设置数字
- (void)setButton:(UIButton *)button title:(NSString *)numberString placeholder:(NSString *)placeholder {

    NSInteger number = [numberString integerValue];
    if (number >= 10000) {
        
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if (number == 0) {
    
        [button setTitle:placeholder forState:UIControlStateNormal];
    }else {
    
        [button setTitle:numberString forState:UIControlStateNormal];
    }
}
#pragma mark - 重写setFrame方法
//当单元格只一组的时候可以设置单元格间的分割线,间距等
- (void)setFrame:(CGRect)frame {

    //改变frame
    frame.origin.y += MKMargin;
    frame.size.height -= MKMargin;
    
    //重新赋值给系统布局时用的cellframe
    [super setFrame:frame];
}
#pragma mark - 按钮点击
- (IBAction)more {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil
                                                    preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MKLog(@"收藏");
        //需要判断是否登录,如果未登录
        [self isNeededLogin];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        MKLog(@"举报");
        //需要判断是否登录,如果未登录
        [self isNeededLogin];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        MKLog(@"取消");
    }]];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)ding {
    
    MKLogFunc
}
- (IBAction)cai {
    
    MKLogFunc
}
- (IBAction)share {
    
    MKLogFunc
}
- (IBAction)comment {
    
    MKLogFunc
}

/**
 确定是否跳转到登录界面
 */
- (void)isNeededLogin {

    UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"要登录才可以哦!" message:@"快去登录吧^_^" preferredStyle:UIAlertControllerStyleAlert];
    [loginAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //登录界面
        [self.window.rootViewController presentViewController:[[MKLoginViewController alloc] init] animated:YES completion:nil];
    }]];
    [loginAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        MKLog(@"取消登录");
    }]];
    [self.window.rootViewController presentViewController:loginAlert animated:YES completion:nil];
}
@end
