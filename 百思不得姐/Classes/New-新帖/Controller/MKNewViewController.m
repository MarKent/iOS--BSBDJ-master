//
//  MKNewViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKNewViewController.h"

@interface MKNewViewController ()

@end

@implementation MKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MKCommonBgColor;
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

#pragma mark - 按钮点击事件
- (void)tagClick {
    
    MKLogFunc
}

@end
