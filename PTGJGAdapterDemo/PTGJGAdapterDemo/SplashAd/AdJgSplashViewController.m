//
//  AdJgSplashViewController.m
//  ADJgSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdJgSplashViewController.h"
#import <ADJgSDK/ADJgSDKSplashAd.h>
#import <ADJgKit/UIColor+ADJgKit.h>
#import <ADJgKit/ADJgKitMacros.h>
#import "ADJgSplashSkipView.h"
#import "ADJgRingProgressView.h"
@interface AdJgSplashViewController ()<ADJgSDKSplashAdDelegate>

@property (nonatomic, strong) ADJgSDKSplashAd *splashAd;

@property (nonatomic, strong) ADJgSplashSkipView *skipNormalView;

@property (nonatomic, strong) ADJgRingProgressView *skipRingView;

@end

@implementation AdJgSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"开屏广告";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self loadSplashAd];
}


// 开屏测试id 518f5daa123ec3e866
- (void)loadSplashAd{
    self.splashAd = [[ADJgSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = self;
    self.splashAd.posId = @"98d35687b40110d8bd";
    self.splashAd.tolerateTimeout = 4;
    self.splashAd.needBottomSkipButton = YES;
    self.splashAd.backgroundColor = [UIColor adjg_getColorWithImage:[UIImage imageNamed:@"750x1334"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADJg_Logo"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    [self.splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:nil];
}

#pragma mark - ADJgSDKSplashAdDelegate
/**
 开屏加载成功
 
 @param splashAd 广告实例
 */
- (void)adjg_splashAdSuccessToLoadAd:(ADJgSDKSplashAd *)splashAd{
    ADJgSDKExtInfo *extInfo = [splashAd adjg_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
}

/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adjg_splashAdSuccessToPresentScreen:(ADJgSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
}

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adjg_splashAdFailToPresentScreen:(ADJgSDKSplashAd *)splashAd failToPresentScreen:(ADJgAdapterErrorDefine *)error{
    NSLog(@"%s",__func__);
    _splashAd = nil;
}

/**
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adjg_splashAdClicked:(ADJgSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
}

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adjg_splashAdClosed:(ADJgSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
    _splashAd = nil;
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adjg_splashAdEffective:(ADJgSDKSplashAd *)splashAd{
    NSLog(@"%s",__func__);
}

@end
