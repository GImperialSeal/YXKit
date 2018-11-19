//
//  NSObject+Draw.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/19.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NSObject+Draw.h"

@implementation NSObject (Draw)
- (UIImage *)yx_drawImage:(CGRect)rect context:(void(^)(CGContextRef ctx,CGRect rect))contextBlock{
    //创建CGContextRef
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    contextBlock(context,rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

/**
 画圆形
 
 @param context ctx
 @param rect rect
 @param isFill 填充或者画边框
 */
- (void)yx_drawRound:(CGContextRef )context rect:(CGRect)rect fill: (BOOL)isFill{
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, isFill?kCGPathFillStroke:kCGPathStroke);
}

/**
 画矩形
 
 @param context ctx
 @param rect rect
 @param isFill 填充 或者 画边框
 */
- (void)yx_drawRectangle:(CGContextRef )context rect:(CGRect)rect fill:(BOOL)isFill{
    isFill?UIRectFill(rect):UIRectFrame(rect);
}


- (UIImage *)yx_drawLinearGradientImage:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    return [self yx_drawImage:rect context:^(CGContextRef ctx, CGRect rect) {
        [self yx_drawLinearGradient:ctx rect:rect alpha:1 startColor:startColor endColor:endColor];
    }];
}

/**
 绘制线性渐变
 
 @param context ctx
 @param rect rect
 @param alpha alpha
 @param startColor 开始clolor
 @param endColor 结束color
 */
- (void)yx_drawLinearGradient:(CGContextRef)context rect:(CGRect)rect alpha:(CGFloat)alpha startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    /*
     1.colorSpace : 颜色空间 rgb
     2.locations:表示渐变的开始位置
     */
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor.CGColor, (__bridge id) endColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(rect.size.width,rect.size.height);
    CGContextSaveGState(context);
    CGContextSetAlpha(context, alpha);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}
@end
