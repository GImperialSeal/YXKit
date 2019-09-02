//
//  UIViewController+Orientation.m
//  zw_app
//
//  Created by 顾玉玺 on 2019/7/10.
//  Copyright © 2019 中维科技. All rights reserved.
//

#import "UIViewController+Orientation.h"
#import "NSObject+CurrentNav.h"
#import <objc/runtime.h>
#import "ReactiveObjC.h"
@interface UIViewController ()
- (UIViewController *)currentRootTopVC;
@end

@implementation UIViewController (Orientation)

// 旋转的处理
- (void)changeDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    if (UIDevice.currentDevice.orientation == deviceOrientation) {
        [self changeDeviceOrientation:UIDeviceOrientationUnknown];
        [self changeDeviceOrientation:deviceOrientation];
    } else {
        [UIDevice.currentDevice setValue:@(deviceOrientation) forKey:@"orientation"];
    }
}

- (void)changeDeviceOrientationToPortrait:(dispatch_block_t)completed {
    CGFloat delay = 0.0;
    if (!UIDeviceOrientationIsPortrait(UIDevice.currentDevice.orientation)) {
        [self changeDeviceOrientation:UIDeviceOrientationPortrait];
        delay = 0.3;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(),^(){
        if (completed) {
            completed();
        }
    });
}

- (void)observerStatusBarOrientation:(OrientationNotificationChangedBlock)block{
    [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        if (block) {
            block([UIApplication sharedApplication].statusBarOrientation);
        }
    }];
}


- (void)orientationMaskAllButUpsideDown{
    self.orientaionMask = UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark - 设备方向的处理
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UIViewController *currentVC = [self currentRootTopVC];
    return currentVC.orientaionLock?UIInterfaceOrientationMaskLandscape: currentVC.orientaionMask;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
    UIViewController *currentVC = [self currentRootTopVC];
    BOOL (^block)(void) = currentVC.OrientaionShouldAutorotateBlock;
    if (block) {
        return block();
    } else {
        return YES;
    }
}


#pragma mark  - set  getter
- (void)setOrientaionLock:(BOOL)orientaionLock{
    objc_setAssociatedObject(self, @selector(orientaionLock), @(orientaionLock), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)orientaionLock{
    return  [objc_getAssociatedObject(self, _cmd) boolValue];
}


- (void)setOrientaionMask:(UIInterfaceOrientationMask)orientaionMask{
    objc_setAssociatedObject(self, @selector(orientaionMask), @(orientaionMask), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIInterfaceOrientationMask)orientaionMask{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return  [obj integerValue];
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)setOrientaionShouldAutorotateBlock:(BOOL (^)(void))OrientaionShouldAutorotateBlock{
    objc_setAssociatedObject(self, @selector(OrientaionShouldAutorotateBlock), OrientaionShouldAutorotateBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL (^)(void))OrientaionShouldAutorotateBlock{
    return  objc_getAssociatedObject(self, _cmd);
}


@end
