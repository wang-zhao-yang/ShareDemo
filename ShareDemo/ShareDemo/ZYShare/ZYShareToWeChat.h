//
//  ZYShareToWeChat.h
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToThirdparty.h"

@interface ZYShareToWeChat : ZYShareToThirdparty

// 单例
+ (ZYShareToWeChat *)sharedManager;
// 分享到微信好友
- (void)shareToWeixinSession;
// 分享到微信朋友圈
- (void)shareToWeixinTimeline;

@end
