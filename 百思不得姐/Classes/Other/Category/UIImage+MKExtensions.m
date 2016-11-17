//
//  UIImage+MKImageStrecth.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/8.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "UIImage+MKExtensions.h"

@implementation UIImage (MKExtensions)


/**
 实例方法：绘制圆形图片
 @return 绘制后的原型图片
 */
- (instancetype)mk_circleImage {

    //开启图像上下文
    UIGraphicsBeginImageContext(self.size);
    //添加一个圆
    CGContextRef currentRef = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(currentRef, rect);
    //裁剪
    CGContextClip(currentRef);
    //绘制
    [self drawInRect:rect];
    //获取之后的圆形图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}
/**
 类方法：通过图片名获取圆形图片
 @param name 图片的名字
 @return 绘制后的原型图片
 */
+ (instancetype)mk_circleImageWithName:(NSString *)name {

    return [[UIImage imageNamed:name] mk_circleImage];
}

/**
 拉伸图片
 @param iamgeName 要拉伸的图片名
 @return 拉伸后的图片
 */
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
