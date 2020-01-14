//
//  Config.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/20.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//




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
