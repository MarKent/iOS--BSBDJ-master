//
//  MKRecommndCell.m
//  百思不得姐
//
//  Created by Mark Kent on 16/11/9.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKRecommndCell.h"
#import "MKRecommndModel.h"
#import <UIImageView+WebCache.h>

@interface MKRecommndCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagNumberLabel;


@end

@implementation MKRecommndCell
#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - 赋值
- (void)setRecommndModel:(MKRecommndModel *)recommndModel {

    _recommndModel = recommndModel;
    
    UIImage *placeholderImage = [UIImage mk_circleImageWithName:@"defaultUserIcon"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:recommndModel.image_list] placeholderImage:placeholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片请求失败，则返回占位图，否则headerImageView.image会被置为nil
        if (image == nil) return;
        //圆角图片
        self.headImageView.image = [image mk_circleImage];
    }];
    
    self.themeLabel.text = recommndModel.theme_name;
    
    if (recommndModel.sub_number >= 10000) {
        CGFloat subNumber = (CGFloat)recommndModel.sub_number/10000;
        self.tagNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",subNumber];
    }else {
        self.tagNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",recommndModel.sub_number];
    }
}

#pragma mark - 按钮点击
- (IBAction)tagClick:(UIButton *)sender {
    //MKLogFunc
}

#pragma mark - 重写setFrame设置分割线
- (void)setFrame:(CGRect)frame {

    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
