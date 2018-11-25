//
//  NSObject+Associated.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Associated)

- (void)yx_runtime_strongValue:(id)value key:(NSString *)key;
- (void)yx_runtime_copyValue:(id)value key:(NSString *)key;
- (id)yx_runtime_valueForkey:(NSString *)key;

@end
