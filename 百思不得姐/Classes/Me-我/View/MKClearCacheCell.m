//
//  MKClearCacheCell.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/13.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define MKBSBDJCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]
@implementation MKClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //显示缓存大小之前
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        self.accessoryView = activityView;
        self.textLabel.text = @"正在计算缓存大小...";
        //在子线程中计算
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //获得计算的缓存并转换数据格式
            unsigned long long cacheSize = [self getCaCheSize];
            NSString *sizeStr = [self setupFormat:cacheSize];
            //在主线程中更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
    
                self.textLabel.text = sizeStr;
                //计算完成后移除小菊花,重新设置小箭头
                self.accessoryView = nil;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            });
        });
        //添加点击手势:会覆盖单元格点击代理方法
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearCache)]];
    }
    return self;
}
#pragma mark -- 缓存大小
- (unsigned long long)getCaCheSize {
    
    unsigned long long size = 0;
    //获取存放缓存的路径
    size = MKBSBDJCachePath.mk_getFileSize;
    size += [SDImageCache sharedImageCache].getSize;
    
    return size;
}
#pragma mark -- 区分数据格式
- (NSString *)setupFormat:(unsigned long long)cacheSize {

    NSString *sizeStr;
    //划分数据格式
    if (cacheSize >= pow(10, 9)) {
        sizeStr = [NSString stringWithFormat:@"清理缓存(%.2fGB)",cacheSize/pow(10, 9)];
    }else if (cacheSize >= pow(10, 6)) {
        sizeStr = [NSString stringWithFormat:@"清理缓存(%.2fMB)",cacheSize/pow(10, 6)];
    }else if (cacheSize >= pow(10, 3)) {
        sizeStr = [NSString stringWithFormat:@"清理缓存(%.2fKB)",cacheSize/pow(10, 3)];
    }else {
        sizeStr = [NSString stringWithFormat:@"清理缓存(%lluB)",cacheSize];
    }
    return sizeStr;
}

#pragma mark -- 清除缓存
- (void)clearCache {

    //显示指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存,等一下哦" ];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //清除SDWebImage缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            //子线程中清除本项目的缓存内容
            [MKBSBDJCachePath mk_clearCacheAtDirectory];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
        
    }];
}
@end
