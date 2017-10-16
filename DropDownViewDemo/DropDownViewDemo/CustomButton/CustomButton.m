//
//  CustomButton.m
//  WisdomClass_teacher
//
//  Created by 思 彭 on 2017/9/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CustomButton.h"
#import "UIViewExt.h"

#define kBtnImgWidth 24

@implementation CustomButton
/*
//调整button内置label和image的相对位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, kBtnImgWidth);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(contentRect.size.width-kBtnImgWidth, 0, kBtnImgWidth, kBtnImgWidth);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}

 */

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 调整文字
    self.titleLabel.left = 0;
    self.titleLabel.top = 0;
    // 自适应宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.height = self.height;
    // 调整图片
    self.imageView.left = self.titleLabel.width;
    self.imageView.centerY = self.titleLabel.centerY;
    self.imageView.width = self.imageView.width;
    self.imageView.height = self.imageView.width;
}

@end
