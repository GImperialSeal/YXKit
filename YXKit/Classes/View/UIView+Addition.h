//
//  UIView+Addition.h
//  LRLZ
//
//  Created by meway on 14-8-10.
//  Copyright (c) 2014年 yeapoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)setFrameWidth:(CGFloat)newWidth;
- (void)setFrameHeight:(CGFloat)newHeight;
- (void)setFrameOriginX:(CGFloat)newX;
- (void)setFrameOriginY:(CGFloat)newY;

@property (nonatomic) CGFloat center_x;
@property (nonatomic) CGFloat center_y;

- (void)removeAllSubviews;
+ (instancetype)lineView;

//View抖动动画(左右抖动)
+ (void)shakeAnimation:(UIView *)view;

+ (void)boundsAnimationWithView:(UIView *)view;
/**
 形变显示动画
 @param duration 动画持续时间
 @param view     执行动画的View
 @param sx       X 的形变比例
 @param sy       Y 的形变比例
 */
+ (void)transformShowAnimationWithDuration:(NSTimeInterval)duration view:(UIView *)view sx:(CGFloat)sx sy:(CGFloat)sy;

/**
 形变消失动画

 @param duration  动画持续时间
 @param view      执行动画的View
 @param superView 执行动画的View的父视图
 @param sx        X 的形变比例
 @param sy        Y 的形变比例
 */
+ (void)transformDissmissAnimationWithDuration:(NSTimeInterval)duration view:(UIView *)view superView:(UIView *)superView sx:(CGFloat)sx sy:(CGFloat)sy;

/**
 *  判断该View 是否 在屏幕上
 */
- (BOOL)isDisplayedInScreen;
/**
 *  当前view的VC
 *
 */
- (UIViewController *)getViewController;
/**
 *  最前面的VC
 *
 */
+ (UIViewController *)frontViewController;
@end
