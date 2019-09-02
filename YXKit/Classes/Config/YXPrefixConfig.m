//
//  Config.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/20.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "YXPrefixConfig.h"
#import "YYKit.h"
#import <NSObject+runtime.h>
@import UIKit;
@implementation YXPrefixConfig


/// 传入你要计算的View的行高
+ (CGFloat)systemLayoutSizeFittingSizeWithWidth:(CGFloat)width contentView:(UIView*)contentView{
    // 获得父容器的宽度，我这里是获取控制器View的宽度
    CGFloat contentViewWidth = width;
    // 新建一个宽度约束
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint
                                                constraintWithItem:contentView
                                                attribute:NSLayoutAttributeWidth
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:nil
                                                attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:1.0
                                                constant:contentViewWidth];
    
    widthFenceConstraint.priority = UILayoutPriorityRequired - 1;

    // 添加宽度约束
    [contentView addConstraint:widthFenceConstraint];
    // 获取约束后的size
    CGSize fittingSize = [contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    // 记得移除
    [contentView removeConstraint:widthFenceConstraint];
    return fittingSize.height;
}




+ (void)nineBlockBoxAutoMargin:(UIView *)sv width:(CGFloat)width rect:(CGRect)rect col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished{
    CGFloat x = (width-rect.size.width*col)/(col+1);
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
    NSMutableArray *subviews = [NSMutableArray array];
    for (UIView *v in sv.subviews) {
        BOOL notSystemView = [[v runtime_getValueForkey:@"notSystemView"] boolValue];
        if (notSystemView) {
            [subviews addObject:v];
        }
    }
    NSInteger currentSubviewsCount = subviews.count;
    
    UIButton * sender;
    for (int i = 0; i< count; i++) {
        if (count > currentSubviewsCount){// 添加
            if ((i > currentSubviewsCount-1) || (currentSubviewsCount == 0)){
                sender = [UIButton buttonWithType:UIButtonTypeCustom];
                sender.tag = i ;
                [sender runtime_setAssignValue:@(YES) key:@"notSystemView"];
                [sv addSubview:sender];
            }else{
                sender = subviews[i];
            }
        }else if (currentSubviewsCount == count){
            sender = subviews[i];
        }else{//移除
            sender = subviews[i];
            for (int i = 0; i< currentSubviewsCount - count; i++) {
                [subviews.lastObject removeFromSuperview];
            }
            currentSubviewsCount = subviews.count;
        }
        [sender removeAllTargets];

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
//+ (void)nineBlockBox:(UIView *)sv rect:(CGRect)rect margin_X:(CGFloat)margin_X margin_Y:(CGFloat)margin_Y col:(NSInteger)col count:(NSInteger)count finishedLayout:(FinishedLayoutBlock)finished{
//    NSInteger currentSubviewsCount = sv.subviews.count;
//    UIButton * sender;
//    for (int i = 0; i< count; i++) {
//        if (count > currentSubviewsCount){// 添加
//            if ((i > currentSubviewsCount-1) || (currentSubviewsCount == 0)){
//                sender = [UIButton buttonWithType:UIButtonTypeCustom];
//                sender.tag = i ;
//                [sv addSubview:sender];
//            }else{
//                sender = sv.subviews[i];
//            }
//        }else if (currentSubviewsCount == count){
//            sender = sv.subviews[i];
//        }else{//移除
//            sender = sv.subviews[i];
//            for (int i = 0; i< currentSubviewsCount - count; i++) {
//                [sv.subviews.lastObject removeFromSuperview];
//            }
//            currentSubviewsCount = sv.subviews.count;
//        }
//        sender.frame = CGRectMake(CGRectGetMinX(rect)+i%col*(rect.size.width+margin_X), CGRectGetMinY(rect)+(i/col)*(rect.size.height+margin_Y), rect.size.width, rect.size.height);
//        if (finished) {
//            finished(sender,i);
//        }
//    }
//}




@end
