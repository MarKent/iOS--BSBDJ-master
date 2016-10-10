//
//  MKMeViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKMeViewController.h"
#import "MKSettingViewController.h"
#import "MKMeCell.h"

@interface MKMeViewController ()

@end

@implementation MKMeViewController
- (instancetype)init {
    
    return [[MKMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupTableView];
}
#pragma mark - UI
- (void)setupUI {
    
    //标题
    self.navigationItem.title = @"我的";
    //设置按钮
    UIBarButtonItem *setItem = [UIBarButtonItem itemWithNormalImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithNormalImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[setItem,moonItem];
}
- (void)setupTableView {

    //背景
    self.tableView.backgroundColor = MKCommonBgColor;
    //每组头尾视图高度及表视图内容偏移量
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = MKMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(MKMargin-35, 0, 0, 0);
    
    //表尾视图
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor purpleColor];
    footerView.mk_height = 200;
    self.tableView.tableFooterView = footerView;
}
#pragma mark - <UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.确定重用标识
    static NSString *ID = @"cell_id";
    //2.从缓存池中去cell
    MKMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.没有则创建
    if (!cell) {
        
        cell = [[MKMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else {
    
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MKLog(@"点击了%ld组%ldh行",indexPath.section+1,indexPath.row+1);
    
}

#pragma mark - 按钮点击
- (void)settingClick {

    MKLogFunc
    MKSettingViewController *settingVc = [[MKSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}
- (void)moonClick {
    
    MKLogFunc
}

@end
