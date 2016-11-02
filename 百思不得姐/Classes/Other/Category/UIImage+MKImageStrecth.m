//
//  UIImage+MKImageStrecth.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/8.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "UIImage+MKImageStrecth.h"

@implementation UIImage (MKImageStrecth)

+ (UIImage *)mk_returnNewImage:(NSString *)iamgeName {

    // 加载图片
    UIImage *image = [UIImage imageNamed:iamgeName];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];

    
    return newImage;
}

@end
