//
//  MKLoginRegisterTextField.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/8.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKLoginRegisterTextField.h"


@interface MKLoginRegisterTextField()

//@property (nonatomic , strong)id observe1;
//@property (nonatomic , strong)id observe2;

@end

@implementation MKLoginRegisterTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //光标颜色
    self.tintColor = [UIColor whiteColor];
    //占位符文字默认颜色
    self.mk_placeholderTextColor = [UIColor grayColor];
    
    //利用一次性通知方法  通知中的block监听
    id observer1 = [[NSNotificationCenter defaultCenter]addObserverForName:UITextFieldTextDidBeginEditingNotification
                    object:self
                     queue:[NSOperationQueue mainQueue]
                usingBlock:^(NSNotification * _Nonnull note) {
        
                    self.mk_placeholderTextColor = [UIColor whiteColor];
                    [[NSNotificationCenter defaultCenter] removeObserver:observer1];
     
    }];
    
    id observer2 = [[NSNotificationCenter defaultCenter]
        addObserverForName:UITextFieldTextDidEndEditingNotification
                    object:self
                     queue:[NSOperationQueue mainQueue]
                usingBlock:^(NSNotification * _Nonnull note) {
        
                    self.mk_placeholderTextColor = [UIColor grayColor];
                    [[NSNotificationCenter defaultCenter] removeObserver:observer2];
    }];
}


@end
