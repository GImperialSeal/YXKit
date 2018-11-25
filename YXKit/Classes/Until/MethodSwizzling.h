//
//  MethodSwizzling.h
//  MGPlayerDemo
//
//  Created by Alfred Zhang on 2018/1/24.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@interface MethodSwizzling : NSObject

@end
