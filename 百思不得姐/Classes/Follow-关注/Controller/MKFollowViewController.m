//
//  MKFollowViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKFollowViewController.h"
#import "MKRecomendFollowViewController.h"
#import "MKLoginViewController.h"

@interface MKFollowViewController ()

@end

@implementation MKFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MKCommonBgColor;
    
    //三级控制器中不建议设置导航栏标题直接使用self.title
    self.navigationItem.title = @"我的关注";
    
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem mk_itemWithNormalImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
}

#pragma mark - 按钮点击事件
- (void)followClick {
    
    MKRecomendFollowViewController *recomendVc = [[MKRecomendFollowViewController alloc] init];
    [self.navigationController pushViewController:recomendVc animated:YES];
}

- (IBAction)loginRegister {
    
    MKLoginViewController *loginRegisterVc = [[MKLoginViewController alloc] init];
    
    [self presentViewController:loginRegisterVc animated:YES completion:NULL];
    
}


@end
