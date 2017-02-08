//
//  ViewController.m
//  ShareDemo
//
//  Created by chuanglong03 on 2016/12/1.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ViewController.h"
#import "ZYShareView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)ZY_share:(UIButton *)sender {
    ZYShareView *shareView = [ZYShareView sharedManager];
    [shareView shareWithTitle:nil description:nil image:nil url:nil category:Share_Category_Text];
    [shareView setupShareView];
}

@end
