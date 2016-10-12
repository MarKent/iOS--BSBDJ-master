//
//  MKSettingViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/29.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKSettingViewController.h"
#import "MKClearCacheCell.h"

static NSString *cell_id = @"MKClearCacheCell";
@interface MKSettingViewController ()

@end

@implementation MKSettingViewController

- (instancetype)init {

    return [[MKSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.tableView.backgroundColor = MKCommonBgColor;
    
    //注册单元格
    [self.tableView registerClass:[MKClearCacheCell class] forCellReuseIdentifier:cell_id];
}
#pragma mark -- <数据源代理>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //从缓存池中去cell
    MKClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    return cell;
}


@end



