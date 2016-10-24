//
//  MKRefreshFooter.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/24.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKRefreshFooter.h"

@implementation MKRefreshFooter

- (void)prepare {

    [super prepare];
    
    //提前刷新
    //self.triggerAutomaticallyRefreshPercent = -1.0;
    
    //不自动刷新
    self.automaticallyRefresh = NO;
}

@end
