//
//  Config.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/20.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#define KW [UIScreen mainScreen].bounds.size.width
#define KH [UIScreen mainScreen].bounds.size.height

#define MGScaleValue(value) value * MIN(KW,KH)/375.f

#define ToolBarH MGScaleValue(40)
// 屎黄色
#define KMainColor [UIColor colorWithRed:190/255.0 green:149/255.0 blue:70/255.0 alpha:1]
#define KRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define KSpece 12


// 字体
#define KMainFont(s) [UIFont fontWithName:@"PingFangSC-Regular" size:floorf(MGScaleValue(s))]
#define KMainFont_Medium(s) [UIFont fontWithName:@"PingFangSC-Medium" size:floorf(MGScaleValue(s))]

#define KFONTSIZE14 [UIFont fontWithName:@"PingFangSC-Regular" size:14]


// 添加id类型属性
#define ASSOCIATED(propertyName, setter, type, objc_AssociationPolicy)\
- (type)propertyName {\
return objc_getAssociatedObject(self, _cmd);\
}\
\
- (void)setter:(type)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), object, objc_AssociationPolicy);\
}

// 添加BOOL类型属性
#define ASSOCIATED_BOOL(propertyName, setter)\
- (BOOL)propertyName {\
NSNumber *value = objc_getAssociatedObject(self, _cmd); return value.boolValue;\
}\
\
- (void)setter:(BOOL)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

// 添加NSInteger类型属性
#define ASSOCIATED_NSInteger(propertyName, setter)\
- (NSInteger)propertyName {\
NSNumber *value = objc_getAssociatedObject(self, _cmd); return value.integerValue;\
}\
\
- (void)setter:(NSInteger)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

// 添加float类型属性
#define ASSOCIATED_float(propertyName, setter)\
- (float)propertyName {\
NSNumber *value = objc_getAssociatedObject(self, _cmd); return value.floatValue;\
}\
\
- (void)setter:(float)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

// 添加double类型属性
#define ASSOCIATED_double(propertyName, setter)\
- (double)propertyName {\
NSNumber *value = objc_getAssociatedObject(self, _cmd); return value.doubleValue;\
}\
\
- (void)setter:(double)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

// 添加long long类型属性
#define ASSOCIATED_longlong(propertyName, setter)\
- (long long)propertyName {\
NSNumber *value = objc_getAssociatedObject(self, _cmd); return value.longLongValue;\
}\
\
- (void)setter:(long long)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), @(object), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

#import <Foundation/Foundation.h>
//#import <objc/runtime.h>

@import UIKit;

typedef void (^FinishedLayoutBlock)(UIButton *sender,int i);

@interface YXPrefixConfig :NSObject


/**
 根据约束获取view的高度
 */
+ (CGFloat)systemLayoutSizeFittingSizeWithWidth:(CGFloat)width contentView:(UIView*)contentView;


/**
 根据字符串时间 转换为秒
 format: 只能转换 此格式 00:00:00
 @param text 时间
 @return 秒数
 
 */
+ (NSInteger)transformSecoundFrom:(NSString *)text;

/**
 秒转时间
 @param secound 秒
 @return 时间字符串 format 00:00:00 不超过1小时 00:00
 */
+ (NSString *)transformTimeFrom:(NSInteger)secound;

+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin:(CGFloat)margin col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished;

+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin_X:(CGFloat)margin_X margin_Y:(CGFloat)margin_Y col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished;


// 自动适应间距
+ (void)nineBlockBoxAutoMargin:(UIView *)sv rect:(CGRect)rect col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished;

+ (UIImage *)drawImage:(CGRect)rect context:(void(^)(CGContextRef ctx,CGRect rect))contextBlock;

+ (void)drawRound:(CGContextRef )context rect:(CGRect)rect fill: (BOOL)isFill;

//  画矩形
+ (void)drawRectangle:(CGContextRef )context rect:(CGRect)rect fill:(BOOL)isFill;

+ (void)drawLinearGradient:(CGContextRef)context rect:(CGRect)rect alpha:(CGFloat)alpha startColor:(UIColor *)startColor endColor:(UIColor *)endColor;




@end
