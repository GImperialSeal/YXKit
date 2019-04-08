//
//  NSObject+Associated.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (runtime)
- (void)runtime_setStrongValue:(id)value key:(NSString *)key{
    objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)runtime_setAssignValue:(id)value key:(NSString *)key{
    objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)runtime_setCopyValue:(id)value key:(NSString *)key{
    objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)runtime_getValueForkey:(NSString *)key{
    return objc_getAssociatedObject(self, key.UTF8String);
}




- (NSArray<NSString *> *)runtime_propertieNameList{
    // 方式1:
//    unsigned int count = 0;
//    // copy new create 会开辟内存空间, 因此要释放指针对应的内存空间
//    Ivar *list = class_copyIvarList(self.class, &count);
//
//    for (int i = 0; i<count; i++) {
//        Ivar ivar = list[i];
//        const char *name = ivar_getName(ivar);
//
//        NSLog(@"name: %@",[NSString stringWithCString:name encoding:NSUTF8StringEncoding]);
//    }
//    free(list);
    
    // 方式2:
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        const char *attributes = property_getAttributes(properties[i]);
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
        NSLog(@"attributesStr : %@", attributesStr);
        [temp addObject:str];
    }
    free(properties);
    return temp;

}


#pragma mark -方法交换

- (void)swizzle:(Class)klass originalSelector:(SEL)originalSelector swizzled:(SEL)swizzledSelector originalMethod:(Method)originalMethod swizzledMethod:(Method)swizzledMethod{
    /**
     struct objc_method {
     SEL method_name;        // 方法名称
     charchar *method_typesE;    // 参数和返回类型的描述字串
     IMP method_imp;         // 方法的具体的实现的指针，保存了方法地址
     }
     */

    // class_addMethod:如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;如果方法没有存在,我们则先尝试添加被替换的方法的实现
    BOOL didAddMethod =
    class_addMethod(klass,originalSelector,
        method_getImplementation(swizzledMethod),
        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        // 原方法未实现，则替换原方法防止crash
        class_replaceMethod(klass,swizzledSelector,
            method_getImplementation(originalMethod),
            method_getTypeEncoding(originalMethod));
    }else {
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
// 对象方法替换
- (void)swizzleMethod_instances:(SEL)originalSelector swizzled:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
    [self swizzle:self.class originalSelector:originalSelector swizzled:swizzledSelector originalMethod:originalMethod swizzledMethod:swizzledMethod];
}

+ (void)swizzleInstanceMethodWithClass:(Class)klass orginalMethod:(SEL)originalSelector swizzled:(SEL)replaceSelector {
    Method origMethod = class_getInstanceMethod(klass, originalSelector);
    Method replaceMeathod = class_getInstanceMethod(klass, replaceSelector);
    [self swizzle:klass originalSelector:originalSelector swizzled:replaceSelector originalMethod:origMethod swizzledMethod:replaceMeathod];
    
}

//类方法替换
+ (void)swizzleMethod_class:(SEL)originalSelector swizzled:(SEL)replaceSelector {
    [self swizzleClassMethodWithClass:[self class] orginalMethod:originalSelector swizzled:replaceSelector];
}

+ (void)swizzleClassMethodWithClass:(Class)klass orginalMethod:(SEL)originalSelector swizzled:(SEL)replaceSelector {
    // Method中包含IMP函数指针，通过替换IMP，使SEL调用不同函数实现
    Method origMethod = class_getClassMethod(klass, originalSelector);
    Method replaceMeathod = class_getClassMethod(klass, replaceSelector);
    Class metaKlass = objc_getMetaClass(NSStringFromClass(klass).UTF8String);
    [self swizzle:metaKlass originalSelector:originalSelector swizzled:replaceSelector originalMethod:origMethod swizzledMethod:replaceMeathod];
}







@end
