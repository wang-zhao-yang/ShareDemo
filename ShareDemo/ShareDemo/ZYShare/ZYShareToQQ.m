//
//  ZYShareToQQ.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToQQ.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "ZYShareHeader.h"

@implementation ZYShareToQQ

#pragma mark - 单例
+ (ZYShareToQQ *)sharedManager {
    static ZYShareToQQ *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[ZYShareToQQ alloc] init];
    });
    return handle;
}

#pragma mark - 分享到 QQ 好友
- (void)shareToQQSession {
    if ([self isInstalledQQ]) {
        QQApiObject *contentObject = nil;
        if (self.shareCategory == Share_Category_Text) {
            QQApiTextObject *textObject = [QQApiTextObject objectWithText:self.shareDescription];
            contentObject = textObject;
        } else if (self.shareCategory == Share_Category_Image) {
            NSData *imageData = UIImageJPEGRepresentation(self.shareImage, 1);
            NSData *previewImageData = UIImageJPEGRepresentation(self.shareImage, 0.5);
            QQApiImageObject *imageObject = [QQApiImageObject objectWithData:imageData previewImageData:previewImageData title:self.shareTitle description:self.shareDescription];
            contentObject = imageObject;
        } else if (self.shareCategory == Share_Category_WebUrl) {
            NSData *previewImageData = UIImageJPEGRepresentation(self.shareImage, 0.3);
            QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:self.shareUrl] title:self.shareTitle description:self.shareDescription previewImageData:previewImageData];
            contentObject = newsObject;
        }
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:contentObject];
        [QQApiInterface sendReq:req];
    } else {
        Show_Alert(@"未安装 QQ 应用！");
    }
}

#pragma mark - 分享到 QQ 空间
- (void)shareToQQZone {
    if ([self isInstalledQQ]) {
        BOOL isTextOrImage = self.shareCategory == Share_Category_Text || self.shareCategory == Share_Category_Image;
        if (isTextOrImage) {
            Show_Alert(@"QQ 空间不支持该类型分享！");
        } else if (self.shareCategory == Share_Category_WebUrl) {
            NSData *imageData = UIImageJPEGRepresentation(self.shareImage, 1);
            QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:self.shareUrl] title:self.shareTitle description:self.shareDescription previewImageData:imageData];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObject];
            [QQApiInterface SendReqToQZone:req];
        }
    } else {
        Show_Alert(@"未安装 QQ 应用！");
    }
}

#pragma mark - 判断是否安装 QQ 应用
- (BOOL)isInstalledQQ {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}

@end
