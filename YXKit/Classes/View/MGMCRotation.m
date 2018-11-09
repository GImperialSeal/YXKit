//
//  Rotation.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/24.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "MGMCRotation.h"
static MGMCRotation *r = nil;
@implementation MGMCRotation

+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        r = [[self alloc]init];
    });
    return r;
}


/**
 设备方向
 UIDeviceOrientationUnknown, 未知方向，可能是设备(屏幕)斜置
 UIDeviceOrientationPortrait,            设备(屏幕)直立
 UIDeviceOrientationPortraitUpsideDown,  设备(屏幕)直立，上下顛倒
 UIDeviceOrientationLandscapeLeft,       设备(屏幕)向左横置
 UIDeviceOrientationLandscapeRight,      设备(屏幕)向右橫置
 UIDeviceOrientationFaceUp,              设备(屏幕)朝上平躺
 UIDeviceOrientationFaceDown             设备(屏幕)朝下平躺
 @return UIDeviceOrientation
 */
+ (UIDeviceOrientation )deviceOrientation{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    return deviceOrientation;
}


/**
 //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
 */
+ (void)observerDeviceOrientation:(id)observer sel:(SEL)sel{
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:sel name:UIDeviceOrientationDidChangeNotification object:nil];
}

/**
 移除监听者

 @param observer 监听者
 */
+ (void)removeNoti:(id)observer{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}


//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
}
//界面方向改变的处理
- (void)handleStatusBarOrientationChange: (NSNotification *)notification{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIInterfaceOrientationPortrait:
            NSLog(@"界面直立");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"界面直立，上下颠倒");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"界面朝左");
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"界面朝右");
            break;
        default:
            break;
    }
}


+ (UIInterfaceOrientation)interfaceOrientation{
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    return interfaceOrientation;
}


/**
 手机锁定竖屏后，UIApplicationWillChangeStatusBarOrientationNotification和 UIApplicationDidChangeStatusBarOrientationNotification通知也失效了。
 @param observer 观察者
 @param sel 回调方法
 */
+ (void)observerInterfaceOrientation:(id)observer sel:(SEL)sel{
    //以监听UIApplicationDidChangeStatusBarOrientationNotification通知为例
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:sel name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

+ (void)setInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}


/**
 在 vc 中设置
 
   //#pragma mark - 控制屏幕旋转方法
 //是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
 - (BOOL)shouldAutorotate{
     return NO;
 }
 //返回支持的方向
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
     return UIInterfaceOrientationMaskPortrait;
 }
 //由模态推出的视图控制器 优先支持的屏幕方向
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
     return UIInterfaceOrientationPortrait;
 }

 */






@end
