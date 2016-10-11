//
//  MKMeSquareButton.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/11.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKMeSquareButton.h"
#import "MKMeSpuare.h"
#import <UIButton+WebCache.h>

@implementation MKMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}

-(void)layoutSubviews {

    [super layoutSubviews];
    
    //button.imageView
    self.imageView.mk_Y = self.mk_height*0.15;
    self.imageView.mk_width = self.mk_width*0.5;
    self.imageView.mk_height = self.mk_width*0.5;
    self.imageView.mk_centerX = self.mk_width*0.5;
    
    //button.titleLabel
    self.titleLabel.mk_X = 0;
    self.titleLabel.mk_Y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.mk_width = self.mk_width;
    self.titleLabel.mk_height = self.mk_height - self.titleLabel.mk_Y;
}

- (void)setSquare:(MKMeSpuare *)square {

    _square = square;
    
    //赋值:标题 图片
    [self setTitle:self.square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:self.square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"imageBackground"]];
}

@end
