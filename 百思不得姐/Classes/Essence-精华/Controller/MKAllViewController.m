//
//  MKAllViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/20.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKAllViewController.h"
#import "MKHTTPSessionManager.h"
#import "MKAllTopicsModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "MKRefreshHeader.h"
#import "MKRefreshFooter.h"

@interface MKAllViewController ()
/* 模型数组 */
@property (nonatomic , strong)NSMutableArray<MKAllTopicsModel *> *allTopicsModelsArr;
/* 已加载的最后一个数据的maxtime用于上拉加载旧数据 */
@property (nonatomic , copy)NSString *maxtime;
/* 该模块中请求共用一个管理者 */
@property (nonatomic , strong)MKHTTPSessionManager *manager;
@end

@implementation MKAllViewController
#pragma mark - 共用一个SessionManager
- (AFHTTPSessionManager *)manager {

    if (!_manager) {
        
        _manager = [MKHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - controller's cycle of life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    MKLogFunc
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allTopicsModelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.确定重用标识
    static NSString *ID = @"all_cell_id";
    //2.从缓存池中去cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.没有则创建
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.allTopicsModelsArr[indexPath.row].name;
    cell.detailTextLabel.text = self.allTopicsModelsArr[indexPath.row].text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.allTopicsModelsArr[indexPath.row].profile_image] placeholderImage:MKImageName(@"defaultUserIcon")];
    return cell;

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
