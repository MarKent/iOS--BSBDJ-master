//
//  MKRefreshHeader.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/24.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKRefreshHeader.h"

@implementation MKRefreshHeader

- (void)prepare {

    [super prepare];
    self.automaticallyChangeAlpha = YES;
    [self setTitle:@"下拉可以刷新哦~" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可刷新啦~" forState:MJRefreshStatePulling];
    [self setTitle:@"再刷新哦~稍等" forState:MJRefreshStateRefreshing];
    
    
    NSArray *pullingImageArr = @[MKImageName(@"bdj_mj_refresh_1"),MKImageName(@"bdj_mj_refresh_2"),MKImageName(@"bdj_mj_refresh_3"),MKImageName(@"bdj_mj_refresh_4")];
    [self setImages:pullingImageArr forState:MJRefreshStateIdle];
    [self setImages:pullingImageArr forState:MJRefreshStatePulling];
    [self setImages:pullingImageArr forState:MJRefreshStateRefreshing];
}

@end
