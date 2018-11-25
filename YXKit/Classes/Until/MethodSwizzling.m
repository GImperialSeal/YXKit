//
//  MethodSwizzling.m
//  MGPlayerDemo
//
//  Created by Alfred Zhang on 2018/1/24.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import "MethodSwizzling.h"
#import <objc/runtime.h>

@implementation MethodSwizzling

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
