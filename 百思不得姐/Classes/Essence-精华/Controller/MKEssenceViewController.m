//
//  MKEssenceViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKEssenceViewController.h"
#import "MKEssenceTitleButton.h"

#define MKIndicaterViewH 2
@interface MKEssenceViewController ()
//中间按钮,控制选中状态
@property (nonatomic , weak)UIButton *seletedTtileButton;
//指示视图
@property (nonatomic , weak)UIView *indicaterView;
@end

@implementation MKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self setupScrollView];
    [self setupTitlesView];
   
}
#pragma mark - 添加View
/**
 滑动视图
 */
- (void)setupScrollView {

    UIScrollView *essenceScrollView = [[UIScrollView alloc] init];
    essenceScrollView.frame = self.view.bounds;
    [self.view addSubview:essenceScrollView];
    essenceScrollView.backgroundColor = MKRandomColor;
}
/**
 添加标题栏视图
 */
- (void)setupTitlesView {

    //标题栏父视图
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.mk_width, 35)];
    titlesView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [self.view addSubview:titlesView];
    //添加按钮
    NSArray *titles = @[@"全  部",@"视 频",@"声   音",@"图     片",@"段子"];
    CGFloat titleButtonW = titlesView.mk_width / titles.count;
    CGFloat titleButtonH = titlesView.mk_height;
    for (int i = 0; i < titles.count; i++) {
        
        MKEssenceTitleButton *titleButton = [MKEssenceTitleButton buttonWithType:UIButtonTypeCustom];
        [titlesView addSubview:titleButton];
        //frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        //标题名
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        //添加事件
        [titleButton addTarget:self action:@selector(titleClik:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //添加按钮下方的指示视图
    UIView *indicaterView = [[UIView alloc] init];
    [titlesView addSubview:indicaterView];
    indicaterView.mk_height = MKIndicaterViewH;
    indicaterView.mk_Y = titlesView.mk_height - MKIndicaterViewH;
    self.indicaterView = indicaterView;
    
    //设置指示视图的颜色
    MKEssenceTitleButton *firstTitleButton = (MKEssenceTitleButton *)[titlesView subviews].firstObject;
    self.indicaterView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    
    //设置界面显示时默认的标题栏按钮的选中状态和指示视图的位置
    //立即计算button.titleLabel的宽度 否则在viewDidLoad方法中还不能获得button.titleLabel的宽度
    [firstTitleButton.titleLabel sizeToFit];
    firstTitleButton.selected = YES;
    //赋值给状态过度按钮
    self.seletedTtileButton = firstTitleButton;
    self.indicaterView.mk_width = firstTitleButton.titleLabel.mk_width;
    self.indicaterView.mk_centerX = firstTitleButton.mk_centerX;
}
#pragma mark - 设置导航栏
- (void)setNav {

    self.view.backgroundColor = MKCommonBgColor;
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}
#pragma mark - 按钮点击事件
- (void)titleClik:(UIButton *)button {

    self.seletedTtileButton.selected = NO;
    button.selected = YES;
    self.seletedTtileButton = button;
    
    [UIView animateWithDuration:0.20 animations:^{
        
        //设置指示视图的宽度和位置
        //方法一:无法计算有换行的文字宽度
        //self.indicaterView.mk_width = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;
        //可以计算换行
        //[button.currentTitle boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> context:<#(nullable NSStringDrawingContext *)#>];
        
        //方法二:直接等于button.titleLabel.mk_height即可
        self.indicaterView.mk_width = button.titleLabel.mk_width;
        self.indicaterView.mk_centerX = button.mk_centerX;
    }];
    
    //MKLogFunc
}
- (void)tagClick {

    MKLogFunc
}
@end
