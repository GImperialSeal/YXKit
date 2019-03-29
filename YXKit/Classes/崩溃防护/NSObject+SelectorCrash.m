//
//  NSObject+SelectorCrash.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/28.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSObject+SelectorCrash.h"
#import "NSObject+runtime.h"
#import <objc/runtime.h>
//https://blog.csdn.net/goodluckwujie/article/details/84255814
@implementation YXUnrecognizedSelectorSolveObject

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)addMethod, "v@:@");
    return YES;
}

id addMethod(id self, SEL _cmd) {
    NSLog(@"CrashProtector: unrecognized selector: %@", NSStringFromSelector(_cmd));
    return 0;
}

@end

@implementation NSObject (SelectorCrash)

+(void)load{
    [self yx_unrecognizedSelectorProtector];
}
+ (void)yx_unrecognizedSelectorProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject *object = [[NSObject alloc] init];
        [object swizzleMethod_instances:@selector(forwardingTargetForSelector:) swizzled:@selector(yx_forwardingTargetForSelector:)];
    });
}

- (id)yx_forwardingTargetForSelector:(SEL)aSelector {
    //注意如果对象的类本事如果重写了forwardInvocation方法的话，就不应该对forwardingTargetForSelector进行重写了，否则会影响到该类型的对象原本的消息转发流程。
    if (class_respondsToSelector([self class], @selector(forwardInvocation:))) {
        IMP impOfNSObject = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        IMP imp = class_getMethodImplementation([self class], @selector(forwardInvocation:));
        if (imp != impOfNSObject) {
            //NSLog(@"class has implemented invocation");
            return nil;
        }
    }
    
    YXUnrecognizedSelectorSolveObject *solveObject = [YXUnrecognizedSelectorSolveObject new];
    solveObject.obj = self;
    return solveObject;
}

@end
