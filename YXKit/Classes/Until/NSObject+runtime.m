//
//  NSObject+Associated.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
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

- (void)runtime_swizzleMethod:(SEL)originalSelector swizzled:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    
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
    return temp;

}
@end
