//
//  RunloopManager.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/22.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "RunloopManager.h"
@interface RunloopManager()
// 任务数组
@property (nonatomic, strong)NSMutableArray *tasks;
@property (nonatomic, strong)NSTimer *timer;
@end
@implementation RunloopManager
// 定义一个观察者
static CFRunLoopObserverRef defaultModeObserver;

// 定义一个runloop
static CFRunLoopRef runloop;



// runloop 每次回调执行一次任务
static void callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"runloop");
    RunloopManager *obj = (__bridge RunloopManager *)info;
    if (obj.tasks.count>0) {
        dispatch_block_t block = obj.tasks.firstObject;
        block();
        [obj.tasks removeObjectAtIndex:0];
    }
}

// 添加任务
- (void)addRunloopTask:(dispatch_block_t)block{
    [self.tasks addObject:block];
}


- (instancetype)init{
    self = [super init];
    if (self) {
        // 开启事件, 为了让runloop 处于忙碌
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
        }];
        self.tasks = [NSMutableArray arrayWithCapacity:20];
        
        
        [self observerRunloopAfterWaiting];
    }
    return self;
}



// 添加观察者
- (void)observerRunloopAfterWaiting{
    
    runloop = CFRunLoopGetCurrent();
    
    // 定义一个观察者
    //    static CFRunLoopObserverRef defaultModeObserver;
    
    
    // 定义一个上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    // 创建一个观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &callback, &context);
    
    // 添加一个观察者
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopCommonModes);
    
    // 释放(C语言有create就需要释放)
    CFRelease(defaultModeObserver);
}

- (void)dealloc{
    
}
// 移除
- (void)removeRunloopObserver{
    CFRunLoopRemoveObserver(runloop, defaultModeObserver, kCFRunLoopCommonModes);
    [self.timer invalidate];
}

@end
