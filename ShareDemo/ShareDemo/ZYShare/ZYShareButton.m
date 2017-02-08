//
//  ZYShareButton.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareButton.h"
#import "ZYShareHeader.h"

@implementation ZYShareButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat rgb = 51/255.0;
    self.titleLabel.textColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, Self_Width, Self_Width);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, Self_Width+kShareBtnVerticalBetweenImageAndTitleLbl, Self_Width, kShareBtnTitleLblHeight);
}

@end
