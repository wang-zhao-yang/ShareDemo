//
//  ZYShareToThirdparty.h
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

// 分享类型
typedef NS_ENUM(NSInteger, Share_Category) {
    // 纯文本
    Share_Category_Text,
    // 图片
    Share_Category_Image,
    // 新闻
    Share_Category_WebUrl
};

@class UIImage;

@interface ZYShareToThirdparty : NSObject

@property (nonatomic, copy)   NSString       *shareTitle;       // 分享标题
@property (nonatomic, copy)   NSString       *shareDescription; // 分享描述
@property (nonatomic, copy)   NSString       *shareUrl;         // 分享链接地址
@property (nonatomic, strong) UIImage        *shareImage;       // 分享缩略图
@property (nonatomic, assign) Share_Category shareCategory;     // 分享类型

// 单例
+ (ZYShareToThirdparty *)sharedManager;

@end
