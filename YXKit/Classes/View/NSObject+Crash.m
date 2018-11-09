//
//  NSObject+Crash.m
//  1111111
//
//  Created by 顾玉玺 on 2018/8/8.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "NSObject+Crash.h"
#import <objc/runtime.h>
@implementation NSObject (Crash)


- (void)safe_crash{
    class_addMethod([self class], @selector(forwardingTargetForSelector:), (IMP)forwardingTargetForSelector, "@@:@");
}

id forwardingTargetForSelector(id self, SEL _cmd, SEL aSelector) {
    //    NSLog(@"Unrecognized selector %@ sent to %@, ***forwarding to Stub", NSStringFromSelector(aSelector), self);
    NSLog(@"00000000000 crash 0000000000000000");
    
    Class StubProxy = objc_allocateClassPair([NSObject class], "StubProxy", 0);
    objc_registerClassPair(StubProxy);
    class_addMethod(StubProxy, aSelector, (IMP)someMethodIMP, "v@:");
    id stub = [[StubProxy alloc] init];
    
    if (![stub respondsToSelector:aSelector]) {
        class_addMethod([stub class], aSelector, (IMP)someMethodIMP, "v@:");
    }
    return stub;
}

void someMethodIMP(id self, SEL _cmd) {
    //    NSLog(@"*** someMethodIMP prevent the crash. *** ");
    
    NSLog(@"00000000000 crash crash crash 0000000000000000");
    
}


@end
