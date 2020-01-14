//
//  YXMacro.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/25.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#ifndef YXMacro_h
#define YXMacro_h

#define KW [UIScreen mainScreen].bounds.size.width
#define KH [UIScreen mainScreen].bounds.size.height
#define KSpace  (KW>375.f?20.f:15.f)
#define KScaleValue(value) value * MIN(KW,KH)/375.f


// 屎黄色
#define KMainColor [UIColor colorWithRed:190/255.0 green:149/255.0 blue:70/255.0 alpha:1]
#define KRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


static inline UIFont* KMainFont_Regular(CGFloat size){
    return [UIFont fontWithName:@"PingFangSC-Regular" size:floorf(size)];
}

static inline UIFont* KMainFont_Medium(CGFloat size){
    return [UIFont fontWithName:@"PingFangSC-Medium" size:floorf(size)];
}



#define singleton(className,methodName) \
\
static className *share = nil; \
\
+ (instancetype)methodName \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
share = [[className alloc] init]; \
}); \
return share; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
share = [super allocWithZone:zone]; \
}); \
return share; \
}\
- (id)copyWithZone:(NSZone *)zone{ \
return share; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return share; \
}



#endif /* YXMacro_h */
