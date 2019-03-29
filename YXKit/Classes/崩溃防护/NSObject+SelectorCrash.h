//
//  NSObject+SelectorCrash.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/28.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXUnrecognizedSelectorSolveObject : NSObject

@property (nonatomic, weak)NSObject *obj;

@end


@interface NSObject (SelectorCrash)
// 未找到方法崩溃的 防护, 默认开启,  +load中调用
+ (void)yx_unrecognizedSelectorProtector;

@end

NS_ASSUME_NONNULL_END
