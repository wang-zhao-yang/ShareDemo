//
//  ZYShareToSinaWeibo.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareToSinaWeibo.h"
#import <WeiboSDK.h>
#import "ZYShareHeader.h"

@implementation ZYShareToSinaWeibo

#pragma mark - 单例
+ (ZYShareToSinaWeibo *)sharedManager {
    static ZYShareToSinaWeibo *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[ZYShareToSinaWeibo alloc] init];
    });
    return handle;
}

#pragma mark - 分享到新浪微博
- (void)shareToSinaWeibo {
    WBAuthorizeRequest *authorizeRequest = [WBAuthorizeRequest request];
    authorizeRequest.redirectURI = SinaWeibo_RedirectUri;
    authorizeRequest.scope = @"all";
    WBMessageObject *messageObject = [self getMessageObject];
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject authInfo:authorizeRequest access_token:nil];
    [WeiboSDK sendRequest:request];
}

#pragma mark - 获取 messageObject
- (WBMessageObject *)getMessageObject {
    WBMessageObject *messageObject = [WBMessageObject message];
    BOOL isInstalledSinaWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]];
    if(isInstalledSinaWeibo) {
        if (self.shareCategory == Share_Category_Text) {
            messageObject.text = NSLocalizedString(self.shareDescription, nil);
        } else if (self.shareCategory == Share_Category_Image) {
            WBImageObject *imageObject = [WBImageObject object];
            imageObject.imageData = UIImageJPEGRepresentation(self.shareImage, 1.0);
            messageObject.imageObject = imageObject;
        } else if (self.shareCategory == Share_Category_WebUrl) {
            if (self.shareImage) {
                WBImageObject *imageObject = [WBImageObject object];
                imageObject.imageData = UIImageJPEGRepresentation(self.shareImage, 1.0);
                messageObject.imageObject = imageObject;
            }
            messageObject.text = [NSString stringWithFormat:@"%@--%@ %@", self.shareTitle, self.shareDescription, self.shareUrl];
        }
    } else {
        Show_Alert(@"未安装新浪微博应用！");
    }
    return messageObject;
}

@end
