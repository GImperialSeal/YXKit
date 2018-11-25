//
//  UIButton+TitleImage.h
//  BoqiiPlant
//
//  Created by 马文涛 on 16/8/5.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (TitleImage)

/**
 *  按钮title和image(本地图片)竖着排列方式
 *
 *  @param frame 按钮rect值
 *  @param v     title和image竖向间隔大小
 *  @param title title内容
 *  @param image image对象
 *  @param font  title字体
 *
 *  @return 按钮对象
 */
- (instancetype)initWithFrame:(CGRect)frame verticalValue:(CGFloat)v title:(NSString *)title image:(UIImage*)image font:(UIFont*)font;

/**
 *  按钮title和image(本地图片)横着排列方式
 *
 *  @param frame 按钮rect值
 *  @param h     title和image横向间隔大小
 *  @param title title内容
 *  @param image image对象
 *  @param font  title字体
 *
 *  @return 按钮对象
 */
- (instancetype)initWithFrame:(CGRect)frame horizontal:(CGFloat)h title:(NSString *)title image:(UIImage*)image font:(UIFont*)font;

/**
 *  按钮title和image(网络图片)竖着排列方式
 *
 *  @param frame   按钮rect值
 *  @param v       title和image竖向间隔大小
 *  @param url     图片地址
 *  @param urlImgSize 网络图片大小（宽高）
 *  @param title   title内容
 *  @param font    title字体
 *
 *  @return 按钮对象
 */
- (instancetype)initWithFrame:(CGRect)frame verticalValue:(CGFloat)v imgUrl:(NSString*)url urlImgSize:(CGSize)urlImgSize title:(NSString *)title font:(UIFont*)font;

/**
 *  按钮title和image(网络图片)横着排列方式
 *
 *  @param frame   按钮rect值
 *  @param h       title和image横向间隔大小
 *  @param url     图片地址
 *  @param urlImgSize 网络图片大小（宽高）
 *  @param title   title内容
 *  @param font    title字体
 *
 *  @return 按钮对象
 */
- (instancetype)initWithFrame:(CGRect)frame horizontal:(CGFloat)h imgUrl:(NSString*)url urlImgSize:(CGSize)urlImgSize title:(NSString *)title font:(UIFont*)font;

@end






