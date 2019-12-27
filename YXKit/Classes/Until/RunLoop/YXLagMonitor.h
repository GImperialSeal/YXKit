//
//  YXLagMonitor.h
//  YXKit
//
//  Created by 顾玉玺 on 2019/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 卡顿监控
// 原理:通过监测Runloop的kCFRunLoopAfterWaiting，用一个子线程去检查，一次循环是否时间太长。

// 问题1 为什么用一个子线程去执行监测?
// 问题2 子线程怎么去监测, 子线程为什么会消失, 用定时器不断执行?
// 问题3 常住子线程的实现

// 步骤:1.创建一个CFRunLoopObserverContext 观察者
//     2.将创建好的观察者 runLoopObserver 添加到主线程 RunLoop 的 common 模式下观察；
//     3.创建一个持续的子线程专门用来监控主线程的 RunLoop 状态；
//     4.一旦发现进入睡眠前的 kCFRunLoopBeforeSources 状态，或者唤醒后的状态 kCFRunLoopAfterWaiting，在设置的时间阈值内一直没有变化，即可判定为卡顿；
//     5.dump 出堆栈的信息，从而进一步分析出具体是哪个方法的执行时间过长；

@interface YXLagMonitor : NSObject


// 创建常住子线程
- (void) addSecondaryThreadAndObserver;

@end

NS_ASSUME_NONNULL_END
