//
//  MKNavigationController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/29.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKNavigationController.h"

@interface MKNavigationController ()

@end

@implementation MKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 重写push方法 设置共同的返回按钮样式

 @param viewController 要push进入的控制器
 @param animated       动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    MKLog(@"%@",viewController);
    if (self.childViewControllers.count >0) {
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn sizeToFit];//要在内容便宜设置之前设置
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(backCick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)backCick {
    
    [self popViewControllerAnimated:YES];
}

@end
