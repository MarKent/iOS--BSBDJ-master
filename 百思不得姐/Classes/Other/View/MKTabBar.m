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
    CGFloat tabBarItemW = self.mk_width/5;
    CGFloat tabBarItemH = self.mk_height;
    CGFloat tabBarItemY = 0;
    int tabBarItemIndex = 0;
    for (UIView *subView in self.subviews) {
        
        //过滤不是标签栏按钮的类
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        
        //重新布局
        subView.frame = CGRectMake(tabBarItemIndex*tabBarItemW, tabBarItemY, tabBarItemW, tabBarItemH);
        //空出中间按钮位置
        if (tabBarItemIndex >= 2) {
            
            subView.frame = CGRectMake(tabBarItemIndex*tabBarItemW+tabBarItemW, tabBarItemY, tabBarItemW, tabBarItemH);
        }
        //索引增加
        tabBarItemIndex++;
    }
    //发布按钮尺寸:注意设置顺序,一般先尺寸再中心点
    self.publicBtn.mk_width = tabBarItemW;
    self.publicBtn.mk_height = tabBarItemH;
    self.publicBtn.mk_centerX = self.mk_width/2;
    self.publicBtn.mk_centerY = tabBarItemH/2;
}

#pragma mark - 按钮点击
- (void)publicClick {
    
    MKLogFunc
}

@end
