//
//  MKRecommndViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/11/9.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKRecommndViewController.h"
#import "MKRecommndCell.h"
#import "MKRecommndModel.h"
#import <MJExtension.h>
#import "MKHTTPSessionManager.h"
#import <SVProgressHUD.h>

@interface MKRecommndViewController ()
//存放模型的数组
@property (nonatomic , strong)NSMutableArray *recommndModelArr;
//网络请求管理
@property (nonatomic , strong)MKHTTPSessionManager *manager;
@end

static NSString *cellID = @"recommnd_cell";

@implementation MKRecommndViewController

- (MKHTTPSessionManager *)manager {

    if (!_manager) {
        _manager = [[MKHTTPSessionManager alloc] init];
    }
    return _manager;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}
- (void)setupUI {
    self.navigationItem.title = @"推荐订阅";
    self.tableView.backgroundColor = MKCommonBgColor;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MKRecommndCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}
#pragma mark - 请求数据
- (void)loadData {
    
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"theme_list";
    params[@"c"] = @"topic";
    
    __weak typeof(self) weakSelf = self;
    [self.manager GET:MKCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSArray *responseArr = responseObject[@"list"];
        //字典数组-->模型数组
        weakSelf.recommndModelArr = [MKRecommndModel mj_objectArrayWithKeyValuesArray:responseArr];
        //刷新数据
        [weakSelf.tableView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled)return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试"];
        });
    }];
}

/**
 界面将要消失时取消因未请求成功而仍然在的HUD和网络请求
 ***注意:如果存在push到下一个界面则要恢复网络请求
 */
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    [self.manager invalidateSessionCancelingTasks:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommndModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MKRecommndCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.recommndModel = self.recommndModelArr[indexPath.row];
    return cell;
}


@end
