//
//  NSObject+Associated.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

/**
 SEL 方法编号
 imp 函数指针
 底层使用 消息发送, 而消息发送的参数:方法的调用者、方法编号以及扩展参数, 因此oc的函数默认带有俩个因此参数即方法的调用者 self, 方法编号 _cmd
 
 栈, 先进后出, 由高地址向低地址访问
 堆,
 当写入的数据超过堆栈的内容大小,导致了数据越界, 有一部分内存会被覆盖, 就造成了堆栈溢出

 函数调用栈, 函数调用的时候, 有可能开辟一段栈空间,存放方法的参数以及局部变量,
 函数调用结束, 栈内存释放, 也就是栈平衡
 
 野指针: 指针指向的内存不可用(不存在或者被覆盖了)
 内存泄漏: 内存使用完后没有清空掉, 这样别人就无法对这块内存进行读写

 */
- (void)runtime_setStrongValue:(id)value key:(NSString *)key;
- (void)runtime_setAssignValue:(id)value key:(NSString *)key;
- (void)runtime_setCopyValue:(id)value key:(NSString *)key;
- (id)runtime_getValueForkey:(NSString *)key;

// 对象方法替换
- (void)swizzleMethod_instances:(SEL)originalSelector swizzled:(SEL)swizzledSelector;

+ (void)swizzleInstanceMethodWithClass:(Class)klass orginalMethod:(SEL)originalSelector swizzled:(SEL)replaceSelector;

//类方法替换
+ (void)swizzleMethod_class:(SEL)originalSelector swizzled:(SEL)replaceSelector;

+ (void)swizzleClassMethodWithClass:(Class)klass orginalMethod:(SEL)originalSelector swizzled:(SEL)replaceSelector;


- (NSArray<NSString *> *)runtime_propertieNameList;


/** class_addMethod方法
  v -- void   @ -- an obj  : -- medthod sel
  v@:@ 返回值void 另外传3个参数
  objc_msgSend(self,@selector(setName:)); 带俩参数
   class_addMethod(myClass, @selector(setName:), (IMP)setName, "v@:@");
*/
@end
