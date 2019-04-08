//
//  NSArray+Crash.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/29.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSArray+Crash.h"
#import "YXCrashLog.h"
#import "NSObject+runtime.h"
#import <objc/runtime.h>
@implementation NSArray (Crash)

/**
 
 iOS 8:下都是__NSArrayI
 iOS11: 之后分 __NSArrayI、  __NSArray0、__NSSingleObjectArrayI
 
 iOS11之前：arr@[]  调用的是[__NSArrayI objectAtIndexed]
 iOS11之后：arr@[]  调用的是[__NSArrayI objectAtIndexedSubscript]
 
 arr为空数组
 *** -[__NSArray0 objectAtIndex:]: index 12 beyond bounds for empty NSArray
 
 arr只有一个元素
 *** -[__NSSingleObjectArrayI objectAtIndex:]: index 12 beyond bounds [0 .. 0]
 
 */

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        [self swizzleInstanceMethodWithClass:objc_getClass("__NSArrayI") orginalMethod:@selector(objectAtIndex:) swizzled:@selector(yx_objectAtIndex:)];
        
        [self swizzleInstanceMethodWithClass:objc_getClass("NSArray") orginalMethod:@selector(objectsAtIndexes:) swizzled:@selector(yx_objectsAtIndexes:)];

    });
}
- (id)yx_objectAtIndex:(NSUInteger)index {
    id obj = nil;
    @try {
        obj = [self yx_objectAtIndex:index];
    } @catch (NSException *exception) {
        [YXCrashLog errorWithException:exception attached:@""];
    } @finally {
        return obj;
    }
}
- (NSArray *)yx_objectsAtIndexes:(NSSet *)set{
    NSArray *array = nil;
    @try {
        array = [self yx_objectsAtIndexes:set];
    } @catch (NSException *exception) {
        [YXCrashLog errorWithException:exception attached:@""];
    } @finally {
        return array;
    }
}



@end
