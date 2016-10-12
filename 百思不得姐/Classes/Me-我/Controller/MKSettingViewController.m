//
//  MKSettingViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/29.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKSettingViewController.h"

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
    
}
#pragma mark -- <数据源代理>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.确定重用标识
    static NSString *ID = @"cell_id";
    //2.从缓存池中去cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.没有则创建
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"清理缓存%zdMB",([self getCaCheSize]/1000)/1000];
    
    return cell;
}

#pragma mark -- 缓存大小
- (unsigned long long)getCaCheSize {
    
    unsigned long long size = 0;
    
    //获取存放缓存的路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *mainPath = [cachePath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    //MKLog(@"%@",mainPath);
    size = mainPath.mk_getFileSize;
    MKLog(@"%zd",size);
    return size;
}
@end



