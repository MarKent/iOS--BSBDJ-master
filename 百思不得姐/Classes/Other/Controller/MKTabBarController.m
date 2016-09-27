//
//  MKTabBarController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/21.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//


#import "MKTabBarController.h"
#import "MKTabBar.h"
#import "MKEssenceViewController.h"
#import "MKNewViewController.h"
#import "MKFollowViewController.h"
#import "MKMeViewController.h"

@interface MKTabBarController ()

@end

@implementation MKTabBarController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置UITabBarItem文字属性-选中与被选中 ****/
    [self setTabBarItemTitleArrts];
    
    /**** 添加子控制器 ****/
    [self addChildsViewControllers];
    
    /** 更换系统TabBar 系统为只读 采用KVC取值**/
    [self changeTabBar];
}

/**
 设置UITabBarItem文字属性
 */
- (void)setTabBarItemTitleArrts {

    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic = [@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]}
                 mutableCopy];
    //通过appearance来设置所有item的文字属性,但是界面渲染后只执行一次
    [[UITabBarItem appearance] setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    selectedDic = [@{NSForegroundColorAttributeName:[UIColor blackColor]} mutableCopy];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
}
/**
 添加子控制器
 */
- (void)addChildsViewControllers {

    [self setupChildViewController:[[UINavigationController alloc] initWithRootViewController:[[MKEssenceViewController alloc]init]]
                             title:@"精华"
                         imageName:@"tabBar_essence_icon"
                 selectedImageName:@"tabBar_essence_click_icon"];
    
    [self setupChildViewController:[[UINavigationController alloc] initWithRootViewController:[[MKNewViewController alloc]init]]
                             title:@"新帖"
                         imageName:@"tabBar_new_icon"
                 selectedImageName:@"tabBar_new_click_icon"];
    
    [self setupChildViewController:[[UINavigationController alloc] initWithRootViewController:[[MKFollowViewController alloc]init]]
                             title:@"关注"
                         imageName:@"tabBar_friendTrends_icon"
                 selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildViewController:[[UINavigationController alloc] initWithRootViewController:[[MKMeViewController alloc]init]]
                             title:@"我"
                         imageName:@"tabBar_me_icon"
                 selectedImageName:@"tabBar_me_click_icon"];
}
/**
 初始化一个子控制器

 @param vC                传入的子控制器
 @param title             标签名
 @param imageName         标签图面
 @param selectedImageName 被选中时的标签图片
 */
- (void)setupChildViewController:(UIViewController *)vC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{

    vC.title = title;
    //图片传nil或者@""会报错,要判断
    if (imageName.length) {
        
        vC.tabBarItem.image = [UIImage imageNamed:imageName];
        vC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    }
    
    [self addChildViewController:vC];
    
}

/**
 更换系统TabBar
 */
- (void)changeTabBar {

   [self setValue:[[MKTabBar alloc] init] forKey:@"tabBar"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
