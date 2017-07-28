//
//  ZYShareView.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ZYShareView.h"
#import "ZYShareHeader.h"
#import "ZYShareButton.h"
#import "ZYShareToSinaWeibo.h"
#import "ZYShareToQQ.h"
#import "ZYShareToWeChat.h"

@interface ZYShareView ()

@property (nonatomic, weak)   UIView                 *grayView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation ZYShareView

#pragma mark - 单例
+ (ZYShareView *)sharedManager {
    static ZYShareView *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[ZYShareView alloc] init];
    });
    return handle;
}

#pragma mark - 添加分享视图
- (void)setupShareView {
    [self setupGrayView];
    [self.grayView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, Share_Device_Height-Self_Height, Share_Device_Width, Self_Height);
    }];
}

#pragma mark - grayView
- (void)setupGrayView {
    UIView *grayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    grayView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [grayView addGestureRecognizer:self.tap];
    [[UIApplication sharedApplication].keyWindow addSubview:grayView];
    self.grayView = grayView;
}

#pragma mark - 手势事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self cancelAction];
}

#pragma mark - sharePlatformAry setter 方法
- (void)setSharePlatformAry:(NSMutableArray *)sharePlatformAry {
    _sharePlatformAry = sharePlatformAry;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUI];
}

#pragma mark - 设置分享平台
- (NSArray *)setupSharePlatform:(Share_Platform)sharePlatform, ... {
    NSMutableArray *platformAry = [NSMutableArray array];
    va_list valist; // va_list 是在 C 语言中解决变参问题的一组宏
    if (@(sharePlatform)) {
        [platformAry addObject:@(sharePlatform)];
        va_start(valist, sharePlatform); // va_start 宏：获取可变参数列表的第一个参数的地址，在这里是获取第一个参数的内存地址，这时 valist 的指针指向第一个参数
        Share_Platform temp; // 临时指针变量
        while ((temp = va_arg(valist, Share_Platform))) { // va_arg 宏：获取可变参数的当前参数，返回指定类型并将指针指向下一参数。首先 valist 的内存地址指向的第一个参数将对应储存的值取出，如果不为 nil，则判断为真，将取出的值添加到数组中，并且将指针指向下一个参数，这样每次循环 valist 所代表的指针偏移量就不断下移直到取出 nil。
            [platformAry addObject:@(temp)];
        }
    }
    return platformAry;
}

#pragma mark - 获取对应平台图片名字
- (NSString *)getPlatformImageName:(Share_Platform)sharePlatform {
    NSString *imageName = nil;
    switch (sharePlatform) {
        case Share_Platform_Weixin_Session:
            imageName = @"微信好友";
            break;
        case Share_Platform_Weixin_Timeline:
            imageName = @"朋友圈";
            break;
        case Share_Platform_QQ_Session:
            imageName = @"QQ好友";
            break;
        case Share_Platform_QQ_Zone:
            imageName = @"QQ空间";
            break;
        case Share_Platform_Sina_Weibo:
            imageName = @"新浪微博";
            break;
    }
    return imageName;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.sharePlatformAry = [NSMutableArray arrayWithArray:[self setupSharePlatform:Share_Platform_Weixin_Session, Share_Platform_Weixin_Timeline, Share_Platform_QQ_Session, Share_Platform_QQ_Zone, Share_Platform_Sina_Weibo, nil]];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    self.frame = CGRectMake(0, Share_Device_Height, Share_Device_Width, Self_Height);
    [self setupShareButton];
    [self setupCancelButton];
    [self setupSegmentLineView];
}

#pragma mark - 分享按钮
- (void)setupShareButton {
    CGFloat shareBtnWidth = (Share_Device_Width-2*kShareVLeftAndRight-(kShareVListNumber-1)*kShareVHorizonal)/kShareVListNumber;
    CGFloat shareBtnHeight = shareBtnWidth+kShareBtnTitleLblHeight+kShareBtnVerticalBetweenImageAndTitleLbl;
    NSInteger count = self.sharePlatformAry.count;
    for (NSInteger i = 0; i < count; i++) {
        NSInteger row = i/kShareVListNumber;
        NSInteger list = i%kShareVListNumber;
        CGFloat shareBtnX = kShareVLeftAndRight+list*(shareBtnWidth+kShareVHorizonal);
        CGFloat shareBtnY = kShareVTopAndBottom+row*(shareBtnHeight+kShareVVertical);
        ZYShareButton *shareBtn = [[ZYShareButton alloc] initWithFrame:CGRectMake(shareBtnX, shareBtnY, shareBtnWidth, shareBtnHeight)];
        Share_Platform platform = (Share_Platform)[self.sharePlatformAry[i] integerValue];
        NSString *normalImageName = [self getPlatformImageName:platform];
        [shareBtn setTitle:normalImageName forState:(UIControlStateNormal)];
        [shareBtn setImage:[UIImage imageNamed:normalImageName] forState:(UIControlStateNormal)];
        NSString *highlightedImageName = [NSString stringWithFormat:@"%@(2)", normalImageName];
        [shareBtn setImage:[UIImage imageNamed:highlightedImageName] forState:(UIControlStateHighlighted)];
        shareBtn.tag = 100+platform;
        [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:shareBtn];
    }
}

#pragma mark - 取消按钮
- (void)setupCancelButton {
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Self_Height-kShareVCancelBtnHeight, Share_Device_Width, kShareVCancelBtnHeight)];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:[UIColor colorWithRed:254/255.0 green:144/255.0 blue:71/255.0 alpha:1] forState:(UIControlStateNormal)];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"取消按下"] forState:(UIControlStateHighlighted)];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:cancelBtn];
}

#pragma mark - 分割线
- (void)setupSegmentLineView {
    UIView *segmentLineView = [[UIView alloc] initWithFrame:CGRectMake(0, Self_Height-kShareVCancelBtnHeight, Share_Device_Width, 1)];
    segmentLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:segmentLineView];
}

#pragma mark - 取消事件
- (void)cancelAction {
    [self.grayView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.grayView removeFromSuperview];
}

#pragma mark - 分享
- (void)shareBtnClicked:(ZYShareButton *)shareBtn {
    switch (shareBtn.tag-100) {
        case Share_Platform_Weixin_Session:
            [[ZYShareToWeChat sharedManager] shareToWeixinSession];
            break;
        case Share_Platform_Weixin_Timeline:
            [[ZYShareToWeChat sharedManager] shareToWeixinTimeline];
            break;
        case Share_Platform_QQ_Session:
            [[ZYShareToQQ sharedManager] shareToQQSession];
            break;
        case Share_Platform_QQ_Zone:
            [[ZYShareToQQ sharedManager] shareToQQZone];
            break;
        case Share_Platform_Sina_Weibo:
            [[ZYShareToSinaWeibo sharedManager] shareToSinaWeibo];
            break;
    }
}

#pragma mark - 设置分享内容
- (void)shareWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category {
    [self addWeixinSessionWithTitle:title description:description image:image url:url category:category];
    [self addWeixinTimelineWithTitle:title description:description image:image url:url category:category];
    [self addQQZoneWithTitle:title description:description image:image url:url category:category];
    [self addQQSessionWithTitle:title description:description image:image url:url category:category];
    [self addSinaWeiboWithTitle:title description:description image:image url:url category:category];
}

#pragma mark - 设置微信好友分享
- (void)addWeixinSessionWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category {
    ZYShareToWeChat *weChat = [ZYShareToWeChat sharedManager];
    weChat.shareTitle = title;
    weChat.shareDescription = description;
    weChat.shareImage = image;
    weChat.shareUrl = url;
    weChat.shareCategory = category;
}

#pragma mark - 设置微信朋友圈分享
- (void)addWeixinTimelineWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category {
    ZYShareToWeChat *weChat = [ZYShareToWeChat sharedManager];
    weChat.shareTitle = title;
    weChat.shareDescription = description;
    weChat.shareImage = image;
    weChat.shareUrl = url;
    weChat.shareCategory = category;
}

#pragma mark - 设置 QQ 好友分享
- (void)addQQSessionWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category {
    ZYShareToQQ *qq = [ZYShareToQQ sharedManager];
    qq.shareTitle = title;
    qq.shareDescription = description;
    qq.shareImage = image;
    qq.shareUrl = url;
    qq.shareCategory = category;
}

#pragma mark - 设置 QQ 空间分享
- (void)addQQZoneWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category {
    ZYShareToQQ *qq = [ZYShareToQQ sharedManager];
    qq.shareTitle = title;
    qq.shareDescription = description;
    qq.shareImage = image;
    qq.shareUrl = url;
    qq.shareCategory = category;
}

#pragma mark - 设置新浪微博分享
- (void)addSinaWeiboWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url category:(Share_Category)category {
    ZYShareToSinaWeibo *sinaWeibo = [ZYShareToSinaWeibo sharedManager];
    sinaWeibo.shareTitle = title;
    sinaWeibo.shareDescription = description;
    sinaWeibo.shareImage = image;
    sinaWeibo.shareUrl = url;
    sinaWeibo.shareCategory = category;
}

@end
