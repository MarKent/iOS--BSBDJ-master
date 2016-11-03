//
//  MKBaseTopicViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/11/3.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKBaseTopicViewController.h"
#import "MKHTTPSessionManager.h"
#import "MKAllTopicsModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "MKRefreshHeader.h"
#import "MKRefreshFooter.h"
#import "MKTopicCell.h"

static NSString *topicCellIdentifyId = @"topic_cell";
@interface MKBaseTopicViewController ()
/* 模型数组 */
@property (nonatomic , strong)NSMutableArray<MKAllTopicsModel *> *allTopicsModelsArr;
/* 已加载的最后一个数据的maxtime用于上拉加载旧数据 */
@property (nonatomic , copy)NSString *maxtime;
/* 该模块中请求共用一个管理者 */
@property (nonatomic , strong)MKHTTPSessionManager *manager;
@end

@implementation MKBaseTopicViewController
//仅用于消除编译器警告
- (MKTopicType)topicType {
    return 0;
}
#pragma mark - 懒加载,共用一个SessionManager
- (AFHTTPSessionManager *)manager {
    
    if (!_manager) {
        
        _manager = [MKHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
}
- (void)setupTableView {
    
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = MKCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 250;
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MKTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellIdentifyId];
}
#pragma mark - 上下拉刷新
- (void)setupRefresh {
    //下拉刷新
    self.tableView.mj_header = [MKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopicsData)];
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载更多
    self.tableView.mj_footer = [MKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopicsData)];
}
#pragma mark - 请求数据
/**
 下拉请求数据
 */
- (void)loadNewTopicsData {
    
    //取消其他网络请求任务保证不同时执行下拉和上拉请求,防止出现问题
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *pamars = [NSMutableDictionary dictionary];
    pamars[@"a"] = @"list";
    pamars[@"c"] = @"data";
    pamars[@"type"] = @([self topicType]);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:pamars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //MKWriteToPlist(responseObject, @"all_topics");
        //获取最后一条数据的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //通过字典中的数组(其中也是字典)转换成模型数组
        self.allTopicsModelsArr = [MKAllTopicsModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新数据
        [self.tableView reloadData];
        //停止下拉刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == NSURLErrorCancelled) {
            //取消任务也会调用这个failure的block
            MKLog(@"任务取消");
        }else {
            MKLog(@"请求错误");
        }
        //不管是取消还是请求错误都停止刷新动画
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 上拉请求数据
 */
- (void)loadMoreTopicsData {
    
    //取消其他网络请求任务保证不同时执行下拉和上拉请求,防止出现问题
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *pamars = [NSMutableDictionary dictionary];
    pamars[@"a"] = @"list";
    pamars[@"c"] = @"data";
    pamars[@"maxtime"] = self.maxtime;
    pamars[@"type"] = @(self.topicType);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:pamars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //MKWriteToPlist(responseObject, @"more_all_topics");
        //再次获取最后一条数据的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //获取更多的数据并转换成模型放于数组中
        NSArray<MKAllTopicsModel *> *moreArr = [MKAllTopicsModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //将请求到的旧数据放于外层的模型数组的最后一个元素之后
        [self.allTopicsModelsArr addObjectsFromArray:moreArr];
        //刷新数据
        [self.tableView reloadData];
        //停止下拉刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == NSURLErrorCancelled) {
            //取消任务也会调用这个failure的block
            MKLog(@"任务取消");
        }else {
            MKLog(@"请求错误");
        }
        //不管是取消还是请求错误都停止刷新动画
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allTopicsModelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellIdentifyId];
    
    cell.allTopicModel = self.allTopicsModelsArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.allTopicsModelsArr[indexPath.row].cellHeight;
}

@end
