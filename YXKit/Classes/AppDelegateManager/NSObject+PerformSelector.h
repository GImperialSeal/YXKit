//
//  NSObject+PerformSelector.h
//  MiGuKit
//
//  Created by 宋乃银 on 2019/1/3.
//  Copyright © 2019 Migu Video Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PerformSelector)

/**
 performSelector 多参数 (params中的key为 @0, @1 等  表示第几个参数)

 @param sel 需要调用的方法
 @param params 参数
 */
+ (id)performSelector:(SEL _Nonnull)sel params:(NSDictionary<NSNumber *, id> *_Nullable)params;

/**
 performSelector 多参数 (params中的key为 @0, @1 等  表示第几个参数)
 
 @param sel 需要调用的方法
 @param params 参数
 */
- (id)performSelector:(SEL _Nonnull)sel params:(NSDictionary<NSNumber *, id> *_Nullable)params;

@end

NS_ASSUME_NONNULL_END
