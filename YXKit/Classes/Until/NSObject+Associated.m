//
//  NSObject+Associated.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NSObject+Associated.h"
#import <objc/runtime.h>
@implementation NSObject (Associated)
- (void)yx_runtime_strongValue:(id)value key:(NSString *)key{
    objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yx_runtime_copyValue:(id)value key:(NSString *)key{
    objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)yx_runtime_valueForkey:(NSString *)key{
    return objc_getAssociatedObject(self, key.UTF8String);
    
}

@end
