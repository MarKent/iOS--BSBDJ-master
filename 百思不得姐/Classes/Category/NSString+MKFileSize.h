//
//  NSString+MKFileSize.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/12.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MKFileSize)
- (unsigned long long)mk_getFileSize;//根据路径计算文件或文件夹大小
- (NSString *)mk_getFileSizeString;//根据大小返回特定的数据格式GB\MB\KB\B
- (void)mk_clearCacheAtDirectory;//根据路径删除内所有内容
@end
