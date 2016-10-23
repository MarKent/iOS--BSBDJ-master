//
//  MKAllViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/20.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKAllViewController.h"
#import <AFNetworking.h>
#import "MKAllTopicsModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

@interface MKAllViewController ()
/* 模型数组 */
@property (nonatomic , strong)NSMutableArray<MKAllTopicsModel *> *allTopicsModelsArr;
@end

@implementation MKAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTopicsData];
    
    MKLogFunc
}
#pragma mark - 请求数据
- (void)loadTopicsData {

    NSMutableDictionary *pamars = [NSMutableDictionary dictionary];
    pamars[@"a"] = @"list";
    pamars[@"c"] = @"data";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:pamars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/markkent/desktop/all_topics.plist" atomically:YES];
        
        //通过字典中的数组转换成模型数组
        self.allTopicsModelsArr = [MKAllTopicsModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新数据
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MKLog(@"请求错误");
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
    static NSString *ID = @"cell_id";
    //2.从缓存池中去cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //3.没有则创建
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.allTopicsModelsArr[indexPath.row].name;
    cell.detailTextLabel.text = self.allTopicsModelsArr[indexPath.row].text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.allTopicsModelsArr[indexPath.row].profile_image] placeholderImage:MKImageName(@"imageBackground")];
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
