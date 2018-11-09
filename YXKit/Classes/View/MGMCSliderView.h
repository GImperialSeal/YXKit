//
//  MGSliderView.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/23.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGMCSliderView;

@protocol MGSliderDelegate<NSObject>

- (void)sliderBeginTracking:(MGMCSliderView *)slider value:(CGFloat)value;

- (void)sliderContinueTracking:(MGMCSliderView *)slider value:(CGFloat)value;

- (void)sliderEndTracking:(MGMCSliderView *)slider value:(CGFloat)value;

@end

@interface MGMCSliderView : UIControl


/**
 value
 */
@property (nonatomic) CGFloat value;


/**
 是否支持单点, 滑动进度 默认为yes
 */
@property (nonatomic) BOOL singleTap;

/**
 是否正在拖动
 */
@property (nonatomic, getter=isDraging) BOOL draging;

/**
 最小值, 默认0.f
 */
@property (nonatomic) CGFloat minimumValue;


/**
 最大值, 默认为1.f
 */
@property (nonatomic) CGFloat maximumValue;


/**
 slider 图片
 */
@property (nonatomic, strong) UIImage *thumbImage;


/**
 delegate
 */
@property (nonatomic, assign) id<MGSliderDelegate> delegate;


/**
 slider 渐变的view
 */
@property (nonatomic, strong) UIImageView *shadowImageView;


/**
 track min color 默认为屎黄色
 */
@property (nonatomic, strong) UIColor *minimumTrackTintColor;

/**
 track max color 默认为白色
 */
@property (nonatomic, strong) UIColor *maximumTrackTintColor;


@end
