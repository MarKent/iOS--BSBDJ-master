//
//  MKFollowViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKFollowViewController.h"

@interface MKFollowViewController ()

@end

@implementation MKFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MKCommonBgColor;
    
    //三级控制器中不建议设置导航栏标题直接使用self.title
    self.navigationItem.title = @"我的关注";
    
    //设置左侧按钮
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [followBtn setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [followBtn setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    //不建议直接使用button.imageView.image.size
    [followBtn sizeToFit];
    [followBtn addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:followBtn];
}

#pragma mark - 按钮点击事件
- (void)followClick {
    
    MKLogFunc
}



@end
