//
//  MKLoginViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/7.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKLoginViewController.h"

@interface MKLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation MKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //修改登录和注册按钮的图片
    [self changeButtonImage];
    
}

#pragma mark - 修改UI
- (void)changeButtonImage {

    // 重新设置登录注册按钮的背景图片
    [self.loginBtn setBackgroundImage:[UIImage returnNewImage:@"loginBtnBg"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage returnNewImage:@"loginBtnBgClick"] forState:UIControlStateHighlighted];
    [self.registerBtn setBackgroundImage:[UIImage returnNewImage:@"loginBtnBg"] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:[UIImage returnNewImage:@"loginBtnBgClick"] forState:UIControlStateHighlighted];
}
#pragma mark - 按钮点击
//关闭界面
- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//注册账号
- (IBAction)loginOrRegister:(UIButton *)sender {
    
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.leftMargin.constant) {
        //如果登录界面背景左边约束不为0,则切换到登录界面
        self.leftMargin.constant = 0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }else {
        //如果登录界面背景左边约束为0,则切换到注册界面
        self.leftMargin.constant = -self.view.mk_width;
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25 animations:^{
    /*
    动画中修改约束不能立即刷新界面布局,所以调用下面的方法强制使用新约束并重新布局
    */
        [self.view layoutIfNeeded];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}
#pragma mark - 修改状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}




@end
