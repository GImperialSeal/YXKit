//
//  MGTableViewList.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/27.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, ActionViewDirection){
    ActionSheetDirectionTop,
    ActionSheetDirectionBottom,
    ActionSheetDirectionLeft,
    ActionSheetDirectionRight,
    ActionSheetDirectionCenter,
};


@interface MGMCActionView : UIView


// tableview
@property (nonatomic, strong) UIView *contentView;

// 遮罩
@property (nonatomic, strong) UIView *maskView;

// 默认 bottom
@property (nonatomic) ActionViewDirection direction;

// 默认0.25
@property (nonatomic) NSTimeInterval duration;

// 默认1.0
@property (nonatomic) NSTimeInterval delay;

+ (MGMCActionView *)actionView;

+ (void)showActionView:(UIView *)contentView
              dirction:(ActionViewDirection)dirction
              animated:(BOOL)animated;


+ (void)dismissActionView:(BOOL)animated delay:(NSTimeInterval)delay completion:(dispatch_block_t)complete;

+ (instancetype)actionView:(UIView *)contentView dirction:(ActionViewDirection)dirction;
- (void)show:(BOOL)animated;
- (void)addView:(UIView *)view animated:(BOOL)animated;
@end
