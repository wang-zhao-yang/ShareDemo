//
//  ZYShareToWeChat.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToWeChat.h"
#import "ZYShareHeader.h"
#import "WXApi.h"

@implementation ZYShareToWeChat

#pragma mark - 单例
+ (ZYShareToWeChat *)sharedManager {
    static ZYShareToWeChat *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[ZYShareToWeChat alloc] init];
    });
    return handle;
}

#pragma mark - 分享到微信好友
- (void)shareToWeixinSession {
    [self shareToWeixinWithScene:WXSceneSession];
}

#pragma mark - 分享到微信朋友圈
- (void)shareToWeixinTimeline {
    [self shareToWeixinWithScene:WXSceneTimeline];
}

#pragma mark - 分享到微信
- (void)shareToWeixinWithScene:(enum WXScene)scene {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        BOOL bText = NO;
        if (self.shareCategory == Share_Category_Text) {
            req.text = self.shareDescription;
            bText = YES;
        } else {
            WXMediaMessage *message = [WXMediaMessage message];
            id mediaObject;
            NSData *thumbImageData = UIImageJPEGRepresentation(self.shareImage, 0.5);
            if (self.shareCategory == Share_Category_Image) {
                WXImageObject *imageObject = [WXImageObject object];
                imageObject.imageData = UIImageJPEGRepresentation(self.shareImage, 1);
                mediaObject = imageObject;
            } else if (self.shareCategory == Share_Category_WebUrl) {
                message.title = self.shareTitle;
                message.description = self.shareDescription;
                WXWebpageObject *pageObject = [WXWebpageObject object];
                pageObject.webpageUrl = self.shareUrl;
                mediaObject = pageObject;
            }
            message.thumbData = thumbImageData;
            message.mediaObject = mediaObject;
            req.message = message;
        }
        req.bText = bText;
        req.scene = scene;
        [WXApi sendReq:req];
    } else {
        Show_Alert(@"未安装微信应用！");
    }
}

@end
