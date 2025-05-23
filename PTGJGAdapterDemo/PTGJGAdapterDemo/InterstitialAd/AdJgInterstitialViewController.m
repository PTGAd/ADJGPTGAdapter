//
//  AdJgInterstitialViewController.m
//  ADJgSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdJgInterstitialViewController.h"
#import <ADJgSDK/ADJgSDKIntertitialAd.h>
#import "UIView+Toast.h"
#import "SetConfigManager.h"
@interface AdJgInterstitialViewController ()<ADJgSDKIntertitialAdDelegate>

@property (nonatomic, strong) ADJgSDKIntertitialAd *intertitialAd;
@property(nonatomic ,assign) BOOL isReady;

@end

@implementation AdJgInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"插屏";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 10;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载插屏" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    loadBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 60);
    [loadBtn addTarget:self action:@selector(loadInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 10;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示插屏" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    showBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+20, UIScreen.mainScreen.bounds.size.width-60, 60);
    _isReady = NO;
}

// 75dc0e44ed48bc2a62 插屏测试id
- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.intertitialAd = [ADJgSDKIntertitialAd new];
    self.intertitialAd.controller = self;
    self.intertitialAd.posId = @"00c1c8904f5b1ecb8c";
    self.intertitialAd.delegate = self;
    self.intertitialAd.tolerateTimeout = 4;
    if (![[SetConfigManager sharedManager].insterstitialAdScenceId isEqualToString:@""])
        self.intertitialAd.scenesId = [SetConfigManager sharedManager].insterstitialAdScenceId;
    // 2、加载插屏广告
    [self.intertitialAd loadAdData];
}

- (void)showInterstitialAd {
    if (_isReady) {
        [self.intertitialAd show];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
    
}

#pragma mark - ADJgSDKIntertitialAdDelegate
/**
 ADJgSDKIntertitialAd请求成功回调
 
 @param interstitialAd 插屏广告实例对象
*/
- (void)adjg_interstitialAdSuccedToLoad:(ADJgSDKIntertitialAd *)interstitialAd{
    ADJgSDKExtInfo *extInfo = [interstitialAd adjg_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
    // 3、展示插屏广告
    _isReady = YES;
    [self.view makeToast:@"广告准备好"];
}

/**
 ADJgSDKIntertitialAd请求失败回调

 @param interstitialAd 插屏广告实例对象
 @param error 失败原因
*/
- (void)adjg_interstitialAdFailedToLoad:(ADJgSDKIntertitialAd *)interstitialAd error:(ADJgAdapterErrorDefine *)error{
    // 4、内存回收
    [self.view makeToast:error.description];
    _intertitialAd = nil;
}

/**
 ADJgSDKIntertitialAd展示在屏幕内回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adjg_interstitialAdDidPresent:(ADJgSDKIntertitialAd *)interstitialAd{
    
}

/**
 ADJgSDKIntertitialAd展示在屏幕内失败回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adjg_interstitialAdFailedToPresent:(ADJgSDKIntertitialAd *)interstitialAd error:(NSError *)error{
    [self.view makeToast:error.description];
}

/**
 ADJgSDKIntertitialAd点击回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adjg_interstitialAdDidClick:(ADJgSDKIntertitialAd *)interstitialAd{
    
}

/**
 ADJgSDKIntertitialAd关闭回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adjg_interstitialAdDidClose:(ADJgSDKIntertitialAd *)interstitialAd{
    // 4、内存回收
    _intertitialAd = nil;
}

/**
 ADJgSDKIntertitialAd展示回调
 
 @param interstitialAd 广告实例
 */
- (void)adjg_interstitialAdExposure:(ADJgSDKIntertitialAd *)interstitialAd{
    
}
@end
