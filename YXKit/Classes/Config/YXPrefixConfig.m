//
//  Config.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/20.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "YXPrefixConfig.h"
@import UIKit;
@implementation YXPrefixConfig

/**
 根据字符串时间 转换为秒
 
 @param text 时间
 @return 秒数
 */
+ (NSInteger)transformSecoundFrom:(NSString *)text {
    NSArray *array = [text componentsSeparatedByString:@":"];
    NSInteger secound = 0;
    NSInteger hour = 0;
    NSInteger minute = 0;
    if (array.count>2) {
        hour =  ((NSString *)array.firstObject).integerValue * 60 * 60;
        minute =  ((NSString *)array[1]).integerValue * 60;
    }else{
        minute =  ((NSString *)array.firstObject).integerValue * 60;
    }
    NSInteger per =  ((NSString *)array.lastObject).integerValue;
    secound = hour + minute + per;
    return secound;
    
}

/// 传入你要计算的View的行高
+ (CGFloat)systemLayoutSizeFittingSizeWithWidth:(CGFloat)width contentView:(UIView*)contentView{
    // 获得父容器的宽度，我这里是获取控制器View的宽度
    CGFloat contentViewWidth = width;
    // 新建一个宽度约束
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    // 添加宽度约束
    [contentView addConstraint:widthFenceConstraint];
    // 获取约束后的size
    CGSize fittingSize = [contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    // 记得移除
    [contentView removeConstraint:widthFenceConstraint];
    return fittingSize.height;
}


/**
 秒转时间
 
 @param secound 秒
 @return 时间字符串  
 */
+ (NSString *)transformTimeFrom:(NSInteger)secound{
    NSInteger hour =  secound / 3600;
    NSInteger minute = (secound % 3600)/60;
    NSInteger per = (secound % 3600)%60;
    NSString *time;
    time = hour>0 ? [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minute,(long)per] :[NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)per];
    return time;
    
}


+ (void)nineBlockBoxAutoMargin:(UIView *)sv rect:(CGRect)rect col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished{
    CGFloat x = ([UIScreen.mainScreen bounds].size.width-rect.size.width*col)/(col+1);
    CGRect r = rect;
    r.origin.x = x;
    rect = r;
    [self nineBlockBox:sv rect:rect margin:x col:col count:count finishedLayout:finished];
}


/// 九宫格
///
/// - Parameters:
///   - rect: x y 距离父视图的距离 及宽高
///   - margin: 间隙
///   - col: 列数
///   - count: 数量
///   - forView:  i && count
+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin:(CGFloat)margin col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished{
    NSInteger currentSubviewsCount = sv.subviews.count;
    UIButton * sender;
    for (int i = 0; i< count; i++) {
        if (count > currentSubviewsCount){// 添加
            if ((i > currentSubviewsCount-1) || (currentSubviewsCount == 0)){
                sender = [UIButton buttonWithType:UIButtonTypeCustom];
                sender.tag = i ;
                [sv addSubview:sender];
            }else{
                sender = sv.subviews[i];
            }
        }else if (currentSubviewsCount == count){
            sender = sv.subviews[i];
        }else{//移除
            sender = sv.subviews[i];
            for (int i = 0; i< currentSubviewsCount - count; i++) {
                [sv.subviews.lastObject removeFromSuperview];
            }
            currentSubviewsCount = sv.subviews.count;
        }
        sender.frame = CGRectMake(CGRectGetMinX(rect)+i%col*(rect.size.width+margin), CGRectGetMinY(rect)+(i/col)*(rect.size.height+margin), rect.size.width, rect.size.height);
        if (finished) {
            finished(sender,i);
        }
    }
}

/// 九宫格
///
/// - Parameters:
///   - rect: x y 距离父视图的距离 及宽高
///   - margin: 间隙
///   - col: 列数
///   - count: 数量
///   - forView:  i && count
+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin_X:(CGFloat)margin_X margin_Y:(CGFloat)margin_Y col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished{
    NSInteger currentSubviewsCount = sv.subviews.count;
    UIButton * sender;
    for (int i = 0; i< count; i++) {
        if (count > currentSubviewsCount){// 添加
            if ((i > currentSubviewsCount-1) || (currentSubviewsCount == 0)){
                sender = [UIButton buttonWithType:UIButtonTypeCustom];
                sender.tag = i ;
                [sv addSubview:sender];
            }else{
                sender = sv.subviews[i];
            }
        }else if (currentSubviewsCount == count){
            sender = sv.subviews[i];
        }else{//移除
            sender = sv.subviews[i];
            for (int i = 0; i< currentSubviewsCount - count; i++) {
                [sv.subviews.lastObject removeFromSuperview];
            }
            currentSubviewsCount = sv.subviews.count;
        }
        sender.frame = CGRectMake(CGRectGetMinX(rect)+i%col*(rect.size.width+margin_X), CGRectGetMinY(rect)+(i/col)*(rect.size.height+margin_Y), rect.size.width, rect.size.height);
        if (finished) {
            finished(sender,i);
        }
    }
}


+ (UIImage *)drawImage:(CGRect)rect context:(void(^)(CGContextRef ctx,CGRect rect))contextBlock{
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
+ (void)drawRound:(CGContextRef )context rect:(CGRect)rect fill: (BOOL)isFill{
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, isFill?kCGPathFillStroke:kCGPathStroke);
}

/**
 画矩形
 
 @param context ctx
 @param rect rect
 @param isFill 填充 或者 画边框
 */
+ (void)drawRectangle:(CGContextRef )context rect:(CGRect)rect fill:(BOOL)isFill{
    isFill?UIRectFill(rect):UIRectFrame(rect);
}



/**
 绘制线性渐变

 @param context ctx
 @param rect rect
 @param alpha alpha
 @param startColor 开始clolor
 @param endColor 结束color
 */
+ (void)drawLinearGradient:(CGContextRef)context rect:(CGRect)rect alpha:(CGFloat)alpha startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
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

+ (void)queue{
//    dispatch_queue_create("111", DISPATCH_QUEUE_SERIAL);
}


@end
