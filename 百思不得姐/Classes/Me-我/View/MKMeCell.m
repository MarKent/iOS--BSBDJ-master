//
//  MKMeCell.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/10.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKMeCell.h"

@implementation MKMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell背景
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage mk_returnNewImage:@"mainCellBackground"]];
        //文字颜色
        self.textLabel.textColor = [UIColor darkGrayColor];
        //cell中的图片填充模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //副视图
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //防止单元格多时重用导致不需要图片的单元格也出现图片
    if (self.imageView.image == nil) return;
    
    //cell.imageView
    self.imageView.mk_Y = MKSmallMargin;
    self.imageView.mk_height = self.contentView.mk_height-MKMargin;
    self.imageView.mk_width = self.imageView.mk_height;
    
    //cell.textLabel
    self.textLabel.mk_X = CGRectGetMaxX(self.imageView.frame)+MKMargin;
}

@end
