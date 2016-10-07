//
//  MKQuickLoginButton.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/7.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKQuickLoginButton.h"

@implementation MKQuickLoginButton

- (void)awakeFromNib {

    [super awakeFromNib];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //图片位置
    self.imageView.mk_Y = 0;
    self.imageView.mk_centerX = self.mk_width*0.5;
    //文字位置
    self.titleLabel.mk_X = 0;
    self.titleLabel.mk_width = self.mk_width;
    self.titleLabel.mk_Y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.mk_height = self.mk_height - self.titleLabel.mk_Y;
}


@end
