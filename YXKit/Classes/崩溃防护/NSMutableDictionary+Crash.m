//
//  NSMutableDictionary+Crash.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/30.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSMutableDictionary+Crash.h"

@implementation NSMutableDictionary (Crash)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSDictionaryM");
    });
}
@end
