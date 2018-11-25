//
//  NSString+Validity.h
//  BoqiiMall
//
//  Created by ysw on 15-3-20.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Help)

+ (BOOL)isNullString:(NSString *)string;

- (BOOL)isWhitespaceAndNewlines;

- (BOOL)isEmail;

- (BOOL)isNumber;

- (BOOL)isLegalName;

- (BOOL)isLegalPrice;

//  身份证号验证
+ (BOOL) validateIdentityCard: (NSString *)input;

/**
 判断字符串是否符合手机号格式。
 @param input 字符串
 @returns 布尔值 YES: 符合 NO: 不符合
 */
+ (BOOL)isPhoneNum:(NSString*) input;
- (BOOL)isPhoneNum;
+ (BOOL)isMobileNum:(NSString*) input;
- (BOOL)isMobileNum;

+ (CGSize)sizeWithText:(NSString*)someText
              fontSize:(CGFloat)fontSize
        constraintSize:(CGSize)contraintSize;
/**
 计算字符串 size
 @someText 字符串
 @fontSize 字符font
 */
+ (CGSize)sizeWithFont:(NSString*)someText
              fontSize:(CGFloat)fontSize
        constraintSize:(CGSize)contraintSize
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

//是否是整数
- (BOOL)isPureInt;

//是否是浮点数
- (BOOL)isPureFloat;

// 去掉html标签 留下原本的字符串
+ (NSString *)filterHTML:(NSString *)html;
@end
