//
//  UIBarButtonItem+MKCommonBarButtonItem.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/28.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "UIBarButtonItem+MKCommonBarButtonItem.h"

@implementation UIBarButtonItem (MKCommonBarButtonItem)

+(instancetype)itemWithNormalImage:(NSString *)normalImageName
                         highImage:(NSString *)highImageName
                            target:(id)target
                            action:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}


@end


