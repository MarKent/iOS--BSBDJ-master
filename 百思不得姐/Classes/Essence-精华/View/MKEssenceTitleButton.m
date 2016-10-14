//
//  MKEssenceTitleButton.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/15.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKEssenceTitleButton.h"

@implementation MKEssenceTitleButton

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

//覆盖原有的按钮点击高亮,不设置点击高亮
- (void)setHighlighted:(BOOL)highlighted {}

@end
