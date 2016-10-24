//
//  NSString+MKFileSize.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/12.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "NSString+MKFileSize.h"

@implementation NSString (MKFileSize)


/**
 根据字符串路径计算该路径下文件或文件夹的大小

 @return 字节数
 */
- (unsigned long long)mk_getFileSize {

    unsigned long long size = 0;
    
    //文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断当前路径下是文件还是文件夹
    /* 方法一:利用当前路径下文件类型判断 */
//    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
//    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {
//        //是文件夹
//        NSDirectoryEnumerator *enumerater = [manager enumeratorAtPath:self];
//        for (NSString *subpath in enumerater) {
//            
//            NSString *filepath = [self stringByAppendingPathComponent:subpath];
//            
//            size += [manager attributesOfItemAtPath:filepath error:nil].fileSize;
//        }
//    }else {
//        //是文件
//        size = attrs.fileSize;
//    }
    /* 方法二:判断当前路径下文件或者文件夹是否存在,是文件还是文件夹 */
    BOOL isDirectory = YES;
    BOOL isFileExist = [manager fileExistsAtPath:self isDirectory:&isDirectory];
    if (!isFileExist)return 0;
    if (isDirectory) {
        //是文件夹
        NSArray *subpaths = [manager subpathsAtPath:self];
        for (NSString *subpath in subpaths) {
            
            NSString *filePath = [self stringByAppendingPathComponent:subpath];
            size += [manager attributesOfItemAtPath:filePath error:nil].fileSize;
        }
    }else {
        //是文件
        size = [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return size;
}

/**
 返回具体数据类型的字符串

 @return 字符串
 */
- (NSString *)mk_getFileSizeString {

    unsigned long long size = [self mk_getFileSize];
    NSString *sizeStr;
    if (size >= pow(10, 9)) {
        sizeStr = [NSString stringWithFormat:@"%.2fGB",size/pow(10, 9)];
    }else if (size >= pow(10, 6)) {
        sizeStr = [NSString stringWithFormat:@"%.2fMB",size/pow(10, 6)];
    }else if (size >= pow(10, 3)) {
        sizeStr = [NSString stringWithFormat:@"%.2fKB",size/pow(10, 3)];
    }else {
        sizeStr = [NSString stringWithFormat:@"%lluB",size];
    }
    
    return sizeStr;
}


/**
 删除当前路径下所有内容,再重新创建空目录
 */
- (void)mk_clearCacheAtDirectory {

    //子线程中删除
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:self error:nil];
    [manager createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:nil];
    
}
@end
