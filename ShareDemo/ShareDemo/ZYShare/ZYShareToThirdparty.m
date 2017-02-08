//
//  ZYShareToThirdparty.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToThirdparty.h"

@implementation ZYShareToThirdparty

#pragma mark - 单例
+ (ZYShareToThirdparty *)sharedManager {
    static ZYShareToThirdparty *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[ZYShareToThirdparty alloc] init];
    });
    return handle;
}

@end
