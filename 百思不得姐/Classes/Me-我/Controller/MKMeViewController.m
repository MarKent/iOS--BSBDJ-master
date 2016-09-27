//
//  MKMeViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKMeViewController.h"

@interface MKMeViewController ()

@end

@implementation MKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MKCommonBgColor;
    
    //标题
    self.navigationItem.title = @"我的";
    
    //设置按钮
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [settingBtn sizeToFit];
    [settingBtn addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    //夜间按钮
    UIButton *moonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonBtn setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonBtn setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [moonBtn sizeToFit];
    [moonBtn addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    //添加到右侧item上
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    UIBarButtonItem *moonItem = [[UIBarButtonItem alloc] initWithCustomView:moonBtn];
    self.navigationItem.rightBarButtonItems = @[setItem,moonItem];
}

#pragma mark - 按钮点击
- (void)settingClick {

    MKLogFunc
}
- (void)moonClick {
    
    MKLogFunc
}

@end
