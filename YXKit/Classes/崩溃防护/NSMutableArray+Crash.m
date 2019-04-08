//
//  NSMutableArray+Crash.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/30.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSMutableArray+Crash.h"
#import "YXCrashLog.h"
#import "NSObject+runtime.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Crash)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithClass:objc_getClass("__NSArrayM") orginalMethod:@selector(removeObjectAtIndex:) swizzled:@selector(yx_removeObjectAtIndex:)];
    });
}

- (void)yx_removeObjectAtIndex:(NSUInteger)index{
    @try {
        [self yx_removeObjectAtIndex:index];
    } @catch (NSException *exception) {
        [YXCrashLog errorWithException:exception attached:@""];
    } @finally {
        
    }
}

- (void)yx_insertObject:(id)anObject atIndex:(NSUInteger)index{
    @try {
        [self yx_insertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        [YXCrashLog errorWithException:exception attached:@""];
    } @finally {
        
    }
}

- (void)yx_addObject:(id)anObject{
    @try {
        [self yx_addObject:anObject];
    } @catch (NSException *exception) {
        [YXCrashLog errorWithException:exception attached:@""];
    } @finally {
    
    }
}

@end
