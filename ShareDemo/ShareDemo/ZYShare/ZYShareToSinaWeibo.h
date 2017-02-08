//
//  ZYShareToSinaWeibo.h
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToThirdparty.h"

@interface ZYShareToSinaWeibo : ZYShareToThirdparty

// 单例
+ (ZYShareToSinaWeibo *)sharedManager;
// 分享到新浪微博
- (void)shareToSinaWeibo;

@end
