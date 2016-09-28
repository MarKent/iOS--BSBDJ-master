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
    UIBarButtonItem *setItem = [UIBarButtonItem itemWithNormalImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithNormalImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
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
