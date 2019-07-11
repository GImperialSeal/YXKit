//
//  UIViewController+Orientation.h
//  zw_app
//
//  Created by 顾玉玺 on 2019/7/10.
//  Copyright © 2019 中维科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrientationNotificationChangedBlock)(UIInterfaceOrientation orientaion);

@interface UIViewController (Orientation)


/**
 锁屏, 保持横屏状态
 */
@property (nonatomic, assign) BOOL orientaionLock;//

// 设备的方向, 默认为竖屏
@property (nonatomic, assign)UIInterfaceOrientationMask orientaionMask;

/**
 设备支持旋转, 默认yes
 */
@property (nonatomic, copy) BOOL(^OrientaionShouldAutorotateBlock)(void);

/**
 改变设备方向

 @param deviceOrientation 方向
 */
- (void)changeDeviceOrientation:(UIDeviceOrientation)deviceOrientation;


/**
 设置成竖屏

 @param completed 完成
 */
- (void)changeDeviceOrientationToPortrait:(dispatch_block_t)completed;

/**
 监听设备的方向

 @param block 方向回调
 */
- (void)observerStatusBarOrientation:(OrientationNotificationChangedBlock)block;

/**
 支持旋转的设置
 */
- (void)orientationMaskAllButUpsideDown;

@end

NS_ASSUME_NONNULL_END
