//
//  MKMeFooterView.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/11.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKMeFooterView.h"
#import "MKHTTPSessionManager.h"
#import "MKMeSpuare.h"
#import <MJExtension.h>
#import "MKMeSquareButton.h"
#import "MKWebViewController.h"

@implementation MKMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        //请求数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[MKHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            
            //字典数组-->模型数组
            NSMutableArray *squaresArr = [MKMeSpuare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //去除相同的数据
            for (int i = 0; i < squaresArr.count; i++) {
                //取每一个
                MKMeSpuare *firstSquare = squaresArr[i];
                for (int j = i+1; j<squaresArr.count; j++) {
                    //剩下的每一个
                    MKMeSpuare *secondSquare = squaresArr[j];
                    //比较,相同名字则移除位置靠后的相同的那一个
                    if ([secondSquare.name isEqualToString: firstSquare.name ]) {
                        
                        [squaresArr removeObject:secondSquare];
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //创建按钮
                [self creatButton:squaresArr];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求失败%@",error);
        }];
    }
    return self;
}

#pragma mark -- 根据模型创建按钮
- (void)creatButton:(NSArray *)squaresArr {

    NSUInteger count = squaresArr.count;
    
    //最大列数确定的
    NSUInteger maxColumsCount = 4;
    CGFloat btnWidth = self.mk_width / 4;
    CGFloat btnHeight = btnWidth;
    
    for (NSUInteger i = 0; i<count; i++) {
        //取得转换后的model
        MKMeSpuare *squareModel = squaresArr[i];
        //创建按钮
        MKMeSquareButton *button = [[MKMeSquareButton alloc]init];
        //给button的model属性赋值
        button.square = squareModel;
        //事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //frame
        button.mk_X = (i % maxColumsCount)*btnWidth;
        button.mk_Y = (i / maxColumsCount)*btnHeight;
        button.mk_width = btnWidth;
        button.mk_height = btnHeight;
        //添加到footerView
        [self addSubview:button];
    }
    
    /*
     类似排列问题的万能公式 此例(已知列数即每行元素个数):(行数=总数+列数-1)/列数
     等价于: if(总数%每行个数 == 0){行数=总数/每行个数}else{行数=(总数/每行个数)+1}
     */
    NSUInteger rows = (squaresArr.count + maxColumsCount -1)/maxColumsCount;
    //设置footerView最终高度
    self.mk_height = rows * btnHeight;
    //self.mk_height = CGRectGetMaxY(self.subviews.lastObject.frame);
    
    //重新设置tableView的FooterView,否则视图加载完成后footerView高度为0
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    //刷新数据,重新计算tableView的contentSize
    [tableView reloadData];
}
#pragma mark -- 按钮点击
- (void)buttonClick:(MKMeSquareButton *)button {
    
    //取得每个按钮对应的一个model
    MKMeSpuare *square = button.square;
    //(用于字符串)prefix前缀<-->suffix后缀
    if ([square.url hasPrefix:@"http"] || [square.url hasPrefix:@"https"]) {
        
        MKWebViewController *webViewVc = [[MKWebViewController alloc] init];
        webViewVc.navigationItem.title = square.name;
        webViewVc.url = square.url;
        
        //取得当前导航控制器
        UITabBarController *tbController = (UITabBarController *)self.window.rootViewController;
        UINavigationController *currentNv = tbController.selectedViewController;
        [currentNv pushViewController:webViewVc animated:YES];
        
        
    }else {
    
        if ([square.url hasSuffix:@"BDJ_To_Check"]) {
            
            NSLog(@"[审帖]");
            
        }else if ([square.url hasSuffix:@"BDJ_To_RankingList"]) {
            
            NSLog(@"[排行榜]");
            
        }else if ([square.url hasSuffix:@"BDJ_To_Mine@dest=2"]) {
            
            NSLog(@"[我的收藏]");
            
        }else if ([square.url hasSuffix:@"BDJ_To_RecentHot"]) {
            
            NSLog(@"[每日排行]");
            
        }else if ([square.url hasSuffix:@"BDJ_To_Cate@cate=3#type=0"]) {
            
            NSLog(@"[随机穿越]");
            
        }else if ([square.url hasSuffix:@"BDJ_To_Mine@dest=1"]) {
            
            NSLog(@"[我的帖子]");
            
        }else if ([square.url hasSuffix:@"App_To_FeedBack"]) {
            
            NSLog(@"[意见反馈]");
            
        }else if ([square.url hasSuffix:@"App_To_SearchUser"]) {
            
            NSLog(@"[搜索]");
            
        }else if ([square.url hasSuffix:@"App_To_MyVideo"]) {
            
            NSLog(@"[下载视频]");
            
        }else {
            NSLog(@"其他更多");
        }
    }
}
@end
