//
//  UIImage+MKImageStrecth.h
//  百思不得姐
//
//  Created by Mark Kent on 16/10/8.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MKExtensions)


/**
 实例方法：圆形图片
 @return 重绘后的圆形图片
 */
- (instancetype)mk_circleImage;

/**
 类方法：通过图片名获取圆形图片
 @param name 图片的名字
 @return 绘制后的原型图片
 */
+ (instancetype)mk_circleImageWithName:(NSString *)name;
/**
 图片拉伸
 @param iamgeName 用到的图片名字
 @return 拉伸后的图片
 */
+ (UIImage *)mk_returnNewImage:(NSString *)iamgeName;
@end
