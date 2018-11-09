//
//  Rotation.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/24.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface MGMCRotation : NSObject
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
+ (UIDeviceOrientation )deviceOrientation;

/**
 观察设备方向

 @param observer self
 @param sel sel
 */
+ (void)observerDeviceOrientation:(id)observer sel:(SEL)sel;


/**
 移除观察者

 @param observer self
 */
+ (void)removeNoti:(id)observer;


+ (void)setInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;


/**
 界面方向

 @return UIInterfaceOrientation
 */
+ (UIInterfaceOrientation)interfaceOrientation;


/**
 观察界面方向

 @param observer self
 @param sel sel
 */
+ (void)observerInterfaceOrientation:(id)observer sel:(SEL)sel;

@end
