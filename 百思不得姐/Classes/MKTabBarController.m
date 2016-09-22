//
//  MKTabBarController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/21.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//


#import "MKTabBarController.h"

@interface MKTabBarController ()

@property (nonatomic , strong)UIButton *publicBtn;

@end

@implementation MKTabBarController

#pragma mark - 懒加载
- (UIButton *)publicBtn {

    if (!_publicBtn) {
    
        //标签栏的发布按钮
        _publicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _publicBtn.bounds = CGRectMake(0, 0, self.tabBar.bounds.size.width/5, self.tabBar.bounds.size.height);
        _publicBtn.center = CGPointMake(self.tabBar.bounds.size.width/2, self.tabBar.bounds.size.height/2);
        [_publicBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publicBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_publicBtn addTarget:self action:@selector(publicClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publicBtn;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置UITabBarItem文字属性-选中与被选中 ****/
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic = [@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]}
                 mutableCopy];
    //通过appearance来设置所有item的文字属性,但是界面渲染后只执行一次
    [[UITabBarItem appearance] setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    selectedDic = [@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} mutableCopy];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    
    
    /**** 添加子控制器 ****/
    [self setupChildViewController:[[UITableViewController alloc] init]
                             title:@"精华"
                         imageName:@"tabBar_essence_icon"
                 selectedImageName:@"tabBar_essence_click_icon"];
    [self setupChildViewController:[[UITableViewController alloc] init]
                             title:@"新帖"
                         imageName:@"tabBar_new_icon"
                 selectedImageName:@"tabBar_new_click_icon"];
    
    //添加一个子控制器用作占位
    [self setupChildViewController:[[UIViewController alloc]init] title:nil imageName:nil selectedImageName:nil];
    
    [self setupChildViewController:[[UITableViewController alloc] init]
                             title:@"关注"
                         imageName:@"tabBar_friendTrends_icon"
                 selectedImageName:@"tabBar_friendTrends_click_icon"];
    [self setupChildViewController:[[UITableViewController alloc] init]
                             title:@"我"
                         imageName:@"tabBar_me_icon"
                 selectedImageName:@"tabBar_me_click_icon"];
    
    
    
}
//因为在viewDidLoad方法中,标签控制器会先初始化,按钮会被最先添加,最终大致按钮被子控制器覆盖
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    //视图将要出现的时保证发布按钮始终添加最上面
    [self.tabBar addSubview:self.publicBtn];
}
/**
 初始化一个子控制器

 @param vC                传入的子控制器
 @param title             标签名
 @param imageName         标签图面
 @param selectedImageName 被选中时的标签图片
 */
- (void)setupChildViewController:(UIViewController *)vC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{

    vC.view.backgroundColor = MKRandomColor;
    vC.title = title;
    //图片传nil或者@""会报错,要判断
    if (imageName.length) {
        
        vC.tabBarItem.image = [UIImage imageNamed:imageName];
        vC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    }
    
    [self addChildViewController:vC];
    
}

#pragma mark - 按钮点击
- (void)publicClick {

    MKLogFunc
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
