//
//  ZYShareView.h
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYShareToThirdparty.h"

// 分享平台
typedef enum {
    Share_Platform_Weixin_Session,  // 微信好友
    Share_Platform_Weixin_Timeline, // 微信朋友圈
    Share_Platform_QQ_Session,      // QQ 好友
    Share_Platform_QQ_Zone,         // QQ 空间
    Share_Platform_Sina_Weibo       // 新浪微博
}Share_Platform;

@interface ZYShareView : UIView

@property (nonatomic, strong) NSMutableArray *sharePlatformAry; // 存储分享平台        

// 单例
+ (ZYShareView *)sharedManager;
// 设置分享内容
- (void)shareWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category;
// 添加分享视图
- (void)setupShareView;
// 设置分享平台
- (NSArray *)setupSharePlatform:(Share_Platform)sharePlatform, ... NS_REQUIRES_NIL_TERMINATION;
// 设置微信好友分享
- (void)addWeixinSessionWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category;
// 设置微信朋友圈分享
- (void)addWeixinTimelineWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category;
// 设置 QQ 好友分享
- (void)addQQSessionWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category;
// 设置 QQ 空间分享
- (void)addQQZoneWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category;
// 设置新浪微博分享
- (void)addSinaWeiboWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category;

@end
