//
//  UITextField+MKPlaceholderTextColor.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/9.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "UITextField+MKPlaceholderTextColor.h"

static NSString * const MKPlaceholderTextColor = @"placeholderLabel.textColor";

@implementation UITextField (MKPlaceholderTextColor)

- (void)setMk_placeholderTextColor:(UIColor *)mk_placeholderTextColor {

    /*
     有占位内容才会有placeholderLabel,所以要提前设置一个,使得内容和颜色的设置顺
     序可以颠倒,但是不能破坏系统原有的方式,即不需要占位文字时,就不添加
     placeholderLabel
     */
    NSString *oldPlaceholderText = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholderText;
    
    //当设置颜色为nil时,使得占位文字颜色为默认(不设置的话还是默认)
    if (self.mk_placeholderTextColor == nil) {
        
        [self setValue:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forKeyPath:MKPlaceholderTextColor];
    }
    
    //设置颜色
    [self setValue:mk_placeholderTextColor forKeyPath:MKPlaceholderTextColor];
}

- (UIColor *)mk_placeholderTextColor {

    return [self valueForKeyPath:MKPlaceholderTextColor];
}
@end
