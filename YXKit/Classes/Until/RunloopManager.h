//
//  RunloopManager.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/22.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunloopManager : NSObject

/**
 添加任务

 @param block 会在runloop循环中执行
 */
- (void)addRunloopTask:(dispatch_block_t)block;


/**
 移除观察者
 */
- (void)removeRunloopObserver;
@end

NS_ASSUME_NONNULL_END
