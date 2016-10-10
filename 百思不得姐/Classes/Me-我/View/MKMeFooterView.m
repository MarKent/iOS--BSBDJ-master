//
//  MKMeFooterView.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/11.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKMeFooterView.h"
#import <AFNetworking.h>
#import "MKMeSpuare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>


@implementation MKMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        //self.mk_height = 200;
        
        //请求数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            
            //[responseObject writeToFile:@"/Users/markkent/desktop/me.plist" atomically:YES];
            //字典数组-->模型数组
            NSArray *squaresArr = [MKMeSpuare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建按钮
            [self creatButton:squaresArr];
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
    int maxColumsCount = 4;
    CGFloat btnWidth = self.mk_width / 4;
    CGFloat btnHeight = btnWidth;
    
    for (NSUInteger i = 0; i<count; i++) {
        
        MKMeSpuare *squareModel = squaresArr[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //排列
        button.mk_X = (i % maxColumsCount)*btnWidth;
        button.mk_Y = (i / maxColumsCount)*btnHeight;
        button.mk_width = btnWidth;
        button.mk_height = btnHeight;
        
        //赋值
        [button setTitle:squareModel.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:squareModel.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"imageBackground"]];
        
        [button setBackgroundColor:MKRandomColor];
        
    }
}
#pragma mark -- 按钮点击
- (void)buttonClick:(UIButton *)button {
    //父视图未设置尺寸,无法响应点击事件
    MKLogFunc
}
@end
