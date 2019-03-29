//
//  NSArray+Helper.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/29.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Helper)

// 去重并且排序, 适合模型数组
/*
 instancetype 作为函数的返回值类型, 获取当前类的类型
 */
- (instancetype)deleteRepeatElementThenSortByKey:(NSString *)key ascending:(BOOL)ascending;

// 去重
- (instancetype)deleteRepeatElement;


@end

NS_ASSUME_NONNULL_END
