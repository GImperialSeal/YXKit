//
//  NSDictionary+Crash.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/30.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import "YXCrashLog.h"
#import "NSObject+runtime.h"
@implementation NSDictionary (Crash)
/**
 *  Can avoid crash method
 *
 *  1. NSDictionary的快速创建方式 NSDictionary *dict = @{@"frameWork" : @"AvoidCrash"}; //这种创建方式其实调用的是2中的方法
 *  2. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
 *
 */
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod_class:@selector(dictionaryWithObjects:forKeys:count:) swizzled:@selector(yx_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)yx_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    id instance = nil;
    @try {
        instance = [self yx_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to remove nil key-values and instance a dictionary.";
        [YXCrashLog errorWithException:exception attached:defaultToDo];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self yx_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}



@end
