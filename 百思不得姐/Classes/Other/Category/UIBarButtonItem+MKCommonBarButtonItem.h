//
//  UIBarButtonItem+MKCommonBarButtonItem.h
//  百思不得姐
//
//  Created by Mark Kent on 16/9/28.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MKCommonBarButtonItem)
+(instancetype)mk_itemWithNormalImage:(NSString *)normalImageName
                         highImage:(NSString *)highImageName
                            target:(id)target
                            action:(SEL)action;
@end
