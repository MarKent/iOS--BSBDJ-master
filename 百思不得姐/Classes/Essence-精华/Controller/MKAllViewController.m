//
//  MKAllViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/20.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKAllViewController.h"

@interface MKAllViewController ()

@end

@implementation MKAllViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 复写父类方法传数据类型值
- (MKTopicType)topicType {
    return MKTopicTypeAll;
}

@end
