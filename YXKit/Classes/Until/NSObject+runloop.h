//
//  NSObject+runloop.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/17.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (runloop)



/**
 1. 保证程序不退出
 2. 负责监听事件, 触摸, 网络, timer
 3. runloop, 做完一件事就进入睡眠模式
 4. runloop, 负责一次循环中渲染ui
 
 */

// UITrackingRunLoopMode  优先 runloop 切换的模式
// NSDefaultRunLoopMode 默认模式
// NSRunLoopCommonModes 占位符(默认和UI )


@end

NS_ASSUME_NONNULL_END
