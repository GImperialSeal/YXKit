//
//  ZWPutTextBaseController.h
//  zw_app
//
//  Created by apple on 2019/9/23.
//  Copyright © 2019年 中维科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PTModalTransitionStyle) {
    PTModalTransitionStyleCoverVertical = 0,//在垂直方向上，显示的时候从下往上；关闭的时候从上往下
    PTModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,//水平翻转，显示的时候从右向左；关闭的时候从左往右
    PTModalTransitionStyleCrossDissolve,//淡入淡出
    PTModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,//边角翻页效果
};

@interface ZWPutTextBaseController : UIViewController

@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,assign) int maxCount;

@property (nonatomic,copy) void(^sureBlock)(NSString *content);

/**
 模态弹出 - 默认垂直向上动效
 注意：（模态弹出a半透明viewcontroller，遮挡住navigationBar和tabbarController）

 @param flag 是否动效
 @param completion 弹出回调
 */
-(void)presentSelfAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

/**
 模态弹出 - 指定显示动效
 注意：（模态弹出a半透明viewcontroller，遮挡住navigationBar和tabbarController）
 
 @param flag 是否动效
 @param style 动画样式
 @param completion 弹出回调
 */
-(void)presentSelfAnimated:(BOOL)flag modalTransitionStyle:(PTModalTransitionStyle)style completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
