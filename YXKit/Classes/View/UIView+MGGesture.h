//
//  UIView+MGGesture.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/23.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_OPTIONS(NSInteger, PanGestureDirection){
    PanDirectionHorizontalMoved = 1 << 0, // 横向移动
    PanDirectionVerticalMoved  = 1 << 1,  // 纵向移动
    PanDirectionLeftMoved = 1 << 2,     // 纵向移动时在左侧
    PanDirectionRightMoved = 1 << 3,     // 纵向移动时在右侧
};

typedef void(^EnventBlockForSingleTap)(CGPoint location);
typedef void(^EnventBlockForDoubleTap)(UIView *touchedView);
typedef void(^EnventBlockForPanBeganMoved)(UIView *touchedView, PanGestureDirection direction);
typedef void(^EnventBlockForPanMoving)(UIView *touchedView, PanGestureDirection direction, CGFloat value);
typedef void(^EnventBlockForPanEndMoved)(UIView *touchedView,PanGestureDirection direction);

// protocol
@protocol MGGestureDelegate <NSObject>

@optional
/**
 单击

 @param touchedView 点击的视图
 */
- (void)enventForSingleTap:(UIView *)touchedView;


/**
 双击

 @param touchedView 双击的视图
 */
- (void)enventForDoubleTap:(UIView *)touchedView;


/**
 拖动手势 开始

 @param touchedView 拖动的视图
 @param direction 拖动的方向
 */
- (void)enventForPanStateBeganMoved:(UIView *)touchedView direction:(PanGestureDirection)direction;


/**
 拖动手势 正在滑动

 @param touchedView 拖动的视图
 @param direction 拖动的方向
 @param value 滑动的距离
 */
- (void)enventForPanStateMoving:(UIView *)touchedView direction:(PanGestureDirection)direction value:(CGFloat)value;

/**
 拖动手势  滑动结束

 @param touchedView 拖动的视图
 @param direction 拖动的方向
 */
- (void)enventForPanStateEndMoved:(UIView *)touchedView direction:(PanGestureDirection)direction;
@end



@interface UIView (MGGesture)

@property (nonatomic, weak) id<MGGestureDelegate> gestureDelagate;


- (void)addGestureForSingleTapWithDelegate:(id<MGGestureDelegate>)delegate;
- (void)addGestureForDoubleTapWithDelegate:(id<MGGestureDelegate>)delegate;
- (void)addGestureForPanWithDelegate:(id<MGGestureDelegate>)delegate;


- (void)addGestureForSingleTapWithBLock:(EnventBlockForSingleTap)singleTapBlock;
- (void)addGestureForDoubleTapWithBlock:(EnventBlockForDoubleTap)doubleTapBlock;
- (void)addGestureForPanWithBlock:(EnventBlockForPanBeganMoved)began moving:(EnventBlockForPanMoving)moving end:(EnventBlockForPanEndMoved)end;


@end
