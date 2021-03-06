//
//  UIView+SizeDecirbe.m
//  百思不得姐
//
//  Created by Mark Kent on 16/9/27.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "UIView+SizeDecirbe.h"

@implementation UIView (SizeDecirbe)

//从xib加载视图
+ (instancetype)mk_viewFromXib {

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
/**
 Width

 @param mk_width 自定义宽度
 */
- (void)setMk_width:(CGFloat)mk_width {

    CGRect frame = self.frame;
    frame.size.width = mk_width;
    self.frame = frame;
}
- (CGFloat)mk_width {

    return self.frame.size.width;
}
/**
 Height
 
 @param mk_height 自定义高度
 */
- (void)setMk_height:(CGFloat)mk_height {
    
    CGRect frame = self.frame;
    frame.size.height = mk_height;
    self.frame = frame;
}
- (CGFloat)mk_height {
    
    return self.frame.size.height;
}
/**
 X
 
 @param mk_X 自定义x坐标
 */
- (void)setMk_X:(CGFloat)mk_X {
    
    CGRect frame = self.frame;
    frame.origin.x = mk_X;
    self.frame = frame;
}
- (CGFloat)mk_X {
    
    return self.frame.origin.x;
}
/**
 Y
 
 @param mk_Y 自定义y坐标
 */
- (void)setMk_Y:(CGFloat)mk_Y {
    
    CGRect frame = self.frame;
    frame.origin.y = mk_Y;
    self.frame = frame;
}
- (CGFloat)mk_Y {
    
    return self.frame.origin.y;
}
/**
 Size
 
 @param mk_size 自定义宽度
 */
- (void)setMk_size:(CGSize)mk_size {
    
    CGRect frame = self.frame;
    frame.size = mk_size;
    self.frame = frame;
}
- (CGSize)mk_size {
    
    return self.frame.size;
}
/**
 Origin
 
 @param mk_origin 自定义位置
 */
- (void)setMk_origin:(CGPoint)mk_origin {
    
    CGRect frame = self.frame;
    frame.origin = mk_origin;
    self.frame = frame;
}
- (CGPoint)mk_origin {
    
    return self.frame.origin;
}
/**
 CenterX
 
 @param mk_centerX 自定义中心点X坐标
 */
- (void)setMk_centerX:(CGFloat)mk_centerX {
    
    CGPoint center = self.center;
    center.x = mk_centerX;
    self.center = center;
}
- (CGFloat)mk_centerX {
    
    return self.center.x;
}
/**
 CenterY
 
 @param mk_centerY 自定义中心点Y坐标
 */
- (void)setMk_centerY:(CGFloat)mk_centerY {
    
    CGPoint center = self.center;
    center.y = mk_centerY;
    self.center = center;
}
- (CGFloat)mk_centerY {
    
    return self.center.y;
}

@end
