//
//  MKTabBar.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/23.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKTabBar.h"

@interface MKTabBar()

@property (nonatomic , strong)UIButton *publicBtn;

@end

@implementation MKTabBar

#pragma mark - 懒加载中间按钮
- (UIButton *)publicBtn {

    if (!_publicBtn) {

        //标签栏的发布按钮
        _publicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publicBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publicBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_publicBtn addTarget:self action:@selector(publicClick) forControlEvents:UIControlEventTouchUpInside];
        //添加
        [self addSubview:_publicBtn];
    }
    return _publicBtn;
}

#pragma mark - 初始化布局
- (void)layoutSubviews {

    [super layoutSubviews];
    
    //标签栏按钮尺寸
    CGFloat btnItemW = self.bounds.size.width/5;
    CGFloat btnItemH = self.bounds.size.height;
    CGFloat btnItemY = 0;
    int index = 0;
    for (UIView *subView in self.subviews) {
        
        //过滤不是标签栏按钮的类
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        
        //重新布局
        subView.frame = CGRectMake(index*btnItemW, btnItemY, btnItemW, btnItemH);
        //空出中间按钮位置
        if (index >= 2) {
            
            subView.frame = CGRectMake(index*btnItemW+btnItemW, btnItemY, btnItemW, btnItemH);
        }
        //索引增加
        index++;
    }
    //发布按钮尺寸
    self.publicBtn.bounds = CGRectMake(0, 0, btnItemW, btnItemH);
    self.publicBtn.center = CGPointMake(self.bounds.size.width/2, btnItemH/2);
}

#pragma mark - 按钮点击
- (void)publicClick {
    
    MKLogFunc
}

@end
