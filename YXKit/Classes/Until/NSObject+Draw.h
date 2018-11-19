//
//  NSObject+Draw.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/19.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Draw)

/**
 填充上下文返回图片

 @param rect 大小
 @param contextBlock 上下文
 @return 图片
 */
- (UIImage *)yx_drawImage:(CGRect)rect context:(void(^)(CGContextRef ctx,CGRect rect))contextBlock;


/**
 画圆

 @param context 上下文
 @param rect 大小
 @param isFill 填充圆, 或者 边框圆
 */
- (void)yx_drawRound:(CGContextRef )context rect:(CGRect)rect fill: (BOOL)isFill;


/**
 画矩形

 @param context 上下文
 @param rect 大小
 @param isFill 填充, 或者 边框
 */
- (void)yx_drawRectangle:(CGContextRef )context rect:(CGRect)rect fill:(BOOL)isFill;


/**
 画渐变

 @param context 上下文
 @param rect 大小
 @param alpha 透明度
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
- (void)yx_drawLinearGradient:(CGContextRef)context rect:(CGRect)rect alpha:(CGFloat)alpha startColor:(UIColor *)startColor endColor:(UIColor *)endColor;


/**
 渐变图

 @param rect 大小
 @param startColor 开始颜色
 @param endColor 结束颜色
 @return 图
 */
- (UIImage *)yx_drawLinearGradientImage:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
