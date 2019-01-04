//
//  NSObject+YXKVO.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/2.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSObject+YXKVO.h"
#import <objc/message.h>
@implementation NSObject (YXKVO)

- (void)yx_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    // 1. 创建一个类
    Class myClass = objc_allocateClassPair(self.class, @"NewClass".UTF8String, 0);
    
    // 2. 注册类
    objc_registerClassPair(myClass);
    
    // 3. 重写setName方法
    // v -- void   @ -- an obj  : -- medthod sel
    // v@:@ 返回值void 另外传3个参数
    // objc_msgSend(self,@selector(setName:)); 带俩参数
    class_addMethod(myClass, @selector(setName:), (IMP)setName, "v@:@");
    
    // 4. 修改isa 指针
    object_setClass(self, myClass);
    
    // 5. 属性绑定
    objc_setAssociatedObject(self, @"observer", observer, OBJC_ASSOCIATION_ASSIGN);
    
    // 返回类型 (*函数名) (参数,参数)
    
}

void setName(id self,SEL _cmd,NSString *newName){
    
    NSObject *observer = objc_getAssociatedObject(self, @"observer");

    // 1.设置成父类的指针调用 父类的set方法
    Class subClass = [self class];
    object_setClass(self, class_getSuperclass(subClass));
    
    
    if (observer) {
        [self observeValueForKeyPath:newName ofObject:observer change:nil context:nil];
    }
    
    // 2.相当去 super setName
    [self setName:newName];
    
    
    
    // 3. 设置子类指针
    object_setClass(self, subClass);
    
}


@end
