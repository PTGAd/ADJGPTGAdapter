//
//  AppDelegate.m
//  PTGJGAdapterDemo
//
//  Created by yongjiu on 2025/5/21.
//

#import "AppDelegate.h"
#import <ADJgSDK/ADJgSDK.h>
#import <ADJgSDK/ADJgSDKSplashAd.h>

@interface AppDelegate ()<ADJgSDKSplashAdDelegate>
@property (nonatomic, strong) ADJgSDKSplashAd *splashAd;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ADJgSDK initWithAppId:@"3263463" completionBlock:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"SDK 初始化失败：%@", error.localizedDescription);
        }
        [self loadSplashAd];
        
    }];
    return YES;
}


- (void)loadSplashAd{
    self.splashAd = [[ADJgSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = [AppDelegate topViewController];
    self.splashAd.posId = @"98d35687b40110d8bd";
    self.splashAd.tolerateTimeout = 4;
    self.splashAd.needBottomSkipButton = YES;
    
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADJg_Logo"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    [self.splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:bottomView];
}
+ (UIViewController *)topViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self topViewControllerWithRootViewController:rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController presentedViewController]) {
        return [self topViewControllerWithRootViewController:rootViewController.presentedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tab.selectedViewController];
    } else {
        return rootViewController;
    }
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

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
