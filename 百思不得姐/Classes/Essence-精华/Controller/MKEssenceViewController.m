//
//  MKEssenceViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKEssenceViewController.h"
#import "MKEssenceTitleButton.h"
#import "MKAllViewController.h"
#import "MKVideoViewController.h"
#import "MKSoundsViewController.h"
#import "MKPictureViewController.h"
#import "MKJokerViewController.h"

#define MKIndicaterViewH 2
@interface MKEssenceViewController ()<UIScrollViewDelegate>
//中间按钮,控制选中状态
@property (nonatomic , weak)UIButton *seletedTtileButton;
//指示视图
@property (nonatomic , weak)UIView *indicaterView;
//滑动视图
@property (nonatomic , weak)UIScrollView *scrolleView;
//标题栏视图
@property (nonatomic , weak)UIView *titlesView;
@end

@implementation MKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self setupChildsViewControllers];
    [self setupScrollView];
    [self setupTitlesView];
   
}
#pragma mark - 添加子控制器
- (void)setupChildsViewControllers {

    [self addChildViewController:[[MKAllViewController alloc] init]];
    [self addChildViewController:[[MKVideoViewController alloc] init]];
    [self addChildViewController:[[MKSoundsViewController alloc] init]];
    [self addChildViewController:[[MKPictureViewController alloc] init]];
    [self addChildViewController:[[MKJokerViewController alloc] init]];
}
#pragma mark - 添加View
/**
 滑动视图
 */
- (void)setupScrollView {

    //不设置滑动视图的自动偏移,否则tableview会下移64+20
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *essenceScrollView = [[UIScrollView alloc] init];
    essenceScrollView.frame = self.view.frame;
    essenceScrollView.showsHorizontalScrollIndicator = NO;
    essenceScrollView.showsVerticalScrollIndicator = NO;
    essenceScrollView.pagingEnabled = YES;
    essenceScrollView.contentSize = CGSizeMake(essenceScrollView.mk_width*self.childViewControllers.count, 0);
    [self.view addSubview:essenceScrollView];
    essenceScrollView.backgroundColor = MKCommonBgColor;
    self.scrolleView = essenceScrollView;
    self.scrolleView.delegate = self;
    
    //默认加载第一个all模块
    [self addChildVcView];
}
/**
 添加标题栏视图
 */
- (void)setupTitlesView {

    //标题栏父视图
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.mk_width, 35)];
    titlesView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    //添加按钮
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
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
        titleButton.tag = i;
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
/**
 懒加载添加子控制器的视图
 */
- (void)addChildVcView {

    //添加要显示的视图 contentOffset.x/self.scrollerView.mk_width = 当前显示范围内的子控制器索引
    NSUInteger index = self.scrolleView.contentOffset.x/self.scrolleView.mk_width;
    UIView *childView = (UIView *)self.childViewControllers[index].view;
    //如果视图已添加便不再调用该方法
    //if (childView.superview) return;
    //if (childView.window) return;
    if ([childView.window.rootViewController isViewLoaded]) return;
    //bounds.x/y = contentOffset.x/y;
    childView.frame = self.scrolleView.bounds;
    [self.scrolleView addSubview:childView];
    //MKLogFunc
}
#pragma mark - 设置导航栏
- (void)setNav {

    self.view.backgroundColor = MKCommonBgColor;
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem mk_itemWithNormalImage:@"MainTagSubIcon"
                                                                  highImage:@"MainTagSubIconClick"
                                                                  target:self
                                                                  action:@selector(tagClick)];
}
#pragma mark - 按钮点击事件
- (void)titleClik:(UIButton *)button {

    //通过状态过度按钮,切换按钮状态
    self.seletedTtileButton.selected = NO;
    button.selected = YES;
    self.seletedTtileButton = button;
    
    [UIView animateWithDuration:0.20 animations:^{
        
        //方法二:直接等于button.titleLabel.mk_height即可
        self.indicaterView.mk_width = button.titleLabel.mk_width;
        self.indicaterView.mk_centerX = button.mk_centerX;
    }];
    //点击按钮滑动到指定模块
    CGPoint offset = self.scrolleView.contentOffset;
    offset.x = self.scrolleView.mk_width*button.tag;
    [self.scrolleView setContentOffset:offset animated:YES];
}
- (void)tagClick {

    MKLogFunc
}
#pragma mark - UIScrollerViewDelegate
/**
 当调用setContentOffset:animation:或scrollRectVisible:animated:时滑动结束才会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    [self addChildVcView];
    //MKLogFunc
}
/**
 手势拖拽结束调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    //同步按钮点击
    NSUInteger index = self.scrolleView.contentOffset.x/self.scrolleView.mk_width;
    UIButton *titleButton = (UIButton *)self.titlesView.subviews[index];
    [self titleClik:titleButton];
    //因为手势拖拽过后产生的偏移量与调用按钮点击事件中计算的偏移量没有变化,即没偏移动画产生,便不会调用上一个代理方法
    [self addChildVcView];
    //MKLogFunc
}
@end
