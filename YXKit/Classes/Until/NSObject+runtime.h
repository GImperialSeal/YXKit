//
//  NSObject+Associated.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

- (void)runtime_setStrongValue:(id)value key:(NSString *)key;
- (void)runtime_setAssignValue:(id)value key:(NSString *)key;
- (void)runtime_setCopyValue:(id)value key:(NSString *)key;
- (id)runtime_getValueForkey:(NSString *)key;

- (void)runtime_swizzleMethod:(SEL)originalSelector swizzled:(SEL)swizzledSelector;

- (NSArray<NSString *> *)runtime_propertieNameList;
@end
