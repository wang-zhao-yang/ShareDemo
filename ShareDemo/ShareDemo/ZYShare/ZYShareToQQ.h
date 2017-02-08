//
//  ZYShareToQQ.h
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToThirdparty.h"

@interface ZYShareToQQ : ZYShareToThirdparty

// 单例
+ (ZYShareToQQ *)sharedManager;
// QQ 好友
- (void)shareToQQSession;
// QQ 空间
- (void)shareToQQZone;

@end
