//
//  Config.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/20.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#define KW [UIScreen mainScreen].bounds.size.width
#define KH [UIScreen mainScreen].bounds.size.height
#define KSpace  KW>375.f?20.f:15.f;
#define KScaleValue(value) value * MIN(KW,KH)/375.f


// 根据STATUS_BAR_HEIGHT判断是否存在热点栏
#define IS_HOTSPOT_CONNECTED (STATUS_BAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)


// 屎黄色
#define KMainColor [UIColor colorWithRed:190/255.0 green:149/255.0 blue:70/255.0 alpha:1]
#define KRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


// 字体
#define KMainFont(s) [UIFont fontWithName:@"PingFangSC-Regular" size:floorf(MGScaleValue(s))]
#define KMainFont_Medium(s) [UIFont fontWithName:@"PingFangSC-Medium" size:floorf(MGScaleValue(s))]

#define KFONTSIZE14 [UIFont fontWithName:@"PingFangSC-Regular" size:14]


#import <Foundation/Foundation.h>
//#import <objc/runtime.h>

//@import UIKit;

typedef void (^FinishedLayoutBlock)(UIButton *sender,int i);

@interface YXPrefixConfig :NSObject


/**
 根据约束获取view的高度
 */
+ (CGFloat)systemLayoutSizeFittingSizeWithWidth:(CGFloat)width contentView:(UIView*)contentView;


+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin:(CGFloat)margin col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished;
//
//+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin_X:(CGFloat)margin_X margin_Y:(CGFloat)margin_Y col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished;


// 自动适应间距
+ (void)nineBlockBoxAutoMargin:(UIView *)sv width:(CGFloat)width rect:(CGRect)rect col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished;



@end
