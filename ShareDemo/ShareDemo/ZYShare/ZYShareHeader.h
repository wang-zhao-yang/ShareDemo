//
//  ZYShareHeader.h
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#ifndef ZYShareHeader_h
#define ZYShareHeader_h

// ZYShareButton
#define kShareBtnVerticalBetweenImageAndTitleLbl 5
#define kShareBtnTitleLblHeight 30

// ZYShareView
#define kShareVCancelBtnHeight 60
#define kShareVTopAndBottom 30
#define kShareVLeftAndRight 36
#define kShareVHorizonal 32
#define kShareVVertical 15
#define kShareVListNumber 4 // 每行显示的个数

// 尺寸
#define Self_Width self.bounds.size.width
#define Share_Device_Width  [[UIScreen mainScreen] bounds].size.width
#define Share_Device_Height [[UIScreen mainScreen] bounds].size.height
#define Share_Row ((self.sharePlatformAry.count-1)/kShareVListNumber+1)
#define Self_Height (((Share_Device_Width-2*kShareVLeftAndRight-(kShareVListNumber-1)*kShareVHorizonal)/kShareVListNumber+kShareBtnTitleLblHeight+kShareBtnVerticalBetweenImageAndTitleLbl)*Share_Row+2*kShareVTopAndBottom+(Share_Row-1)*kShareVVertical+kShareVCancelBtnHeight)

// 提示框
#define Show_Alert(content) \
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
    [alertV show]

#endif
