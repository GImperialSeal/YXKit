//
//  YXCrashLog.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/28.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCrashLog : NSObject

// 根据异常打印日志
+ (void)errorWithException:(NSException *)exception
                  attached:(NSString *)todo;

@end

NS_ASSUME_NONNULL_END
