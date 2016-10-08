//
//  MKLoginRegisterTextField.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/8.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKLoginRegisterTextField.h"

@implementation MKLoginRegisterTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //修改占位符文字颜色
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}



@end
