//
//  MGMCTableViewList.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/27.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "MGMCActionView.h"
#define KW [UIScreen mainScreen].bounds.size.width
#define KH [UIScreen mainScreen].bounds.size.height
#define KSpece 12
@interface MGMCActionView()
@property (nonatomic) CGFloat viewH;
@end
@implementation MGMCActionView

+ (void)showActionView:(UIView *)contentView
              dirction:(ActionViewDirection)dirction
              animated:(BOOL)animated{
    if (![self actionView]) {
        MGMCActionView *v = [[MGMCActionView alloc]initWithFrame:contentView.bounds contentView:contentView direction:dirction];
        v.tag = 10000;
        UIWindow *windows = [UIApplication sharedApplication].keyWindow;
        [windows addSubview:v];
        [v animated:animated delay:0 show:YES completion:nil];
    }
}


+ (MGMCActionView *)actionView{
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    return [windows viewWithTag:10000];
}

+ (void)dismissActionView:(BOOL)animated delay:(NSTimeInterval)delay completion:(dispatch_block_t)complete{
    [[self actionView] animated:animated delay:delay show:NO completion:complete];
}


- (void)animated:(BOOL)animated delay:(NSTimeInterval)delay show:(BOOL)isShow completion:(dispatch_block_t)complete{
    if (isShow) {// 显示
        if (!animated) {
            self.maskView.alpha = 0.5;
            return;
        }
        [self setTableViewTransform];
        [UIView animateWithDuration:_duration delay:_delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.contentView.transform = CGAffineTransformIdentity;
            [self setMaskViewTransform];
            self.maskView.alpha = 0.5;
        } completion:^(BOOL finished) {
            if (complete) {complete();}
        }];
    }else{// 隐藏
        if (!animated) {
            [self setTableViewTransform];
            [self removeFromSuperview];
            if (complete) {complete();}
        }else{
            [UIView animateWithDuration:_duration delay:_delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setTableViewTransform];
                self.maskView.transform = CGAffineTransformIdentity;
                self.maskView.alpha = 0.5;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                if (complete) {complete();}
            }];
        }
    }
}


- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView direction:(ActionViewDirection)direction{
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.direction = direction;
        self.contentView = contentView;
        self.duration = 0.25;
        
        switch (direction) {
            case ActionSheetDirectionTop | ActionSheetDirectionBottom:
                self.viewH = CGRectGetHeight(contentView.frame);
                break;
            case ActionSheetDirectionRight | ActionSheetDirectionRight:
                self.viewH = CGRectGetWidth(contentView.frame);
                break;
            default:
                break;
        }

        [self addSubview:self.maskView];
        [self addSubview:self.contentView];

    }
    return self;
}


// dismiss
- (void)enventForDismiss{
    [self animated:YES delay:0 show:NO completion:nil];
}

- (void)setTableViewTransform{
    switch (_direction) {
        case ActionSheetDirectionTop:
            self.contentView.transform = CGAffineTransformMakeTranslation(0, -_viewH);
            break;
        case ActionSheetDirectionBottom:
            self.contentView.transform = CGAffineTransformMakeTranslation(0, _viewH);
            break;
        case ActionSheetDirectionRight:
            self.contentView.transform = CGAffineTransformMakeTranslation(_viewH, 0);
            break;
        default:
            self.contentView.transform = CGAffineTransformMakeTranslation(-_viewH, 0);
            break;
    }
}
- (void)setMaskViewTransform{
    switch (_direction) {
        case ActionSheetDirectionTop:
            self.maskView.transform = CGAffineTransformMakeTranslation(0, _viewH);
            break;
        case ActionSheetDirectionBottom:
            self.maskView.transform = CGAffineTransformMakeTranslation(0, -_viewH);
            break;
        case ActionSheetDirectionRight:
            self.maskView.transform = CGAffineTransformMakeTranslation(-_viewH, 0);
            break;
        default:
            self.maskView.transform = CGAffineTransformMakeTranslation(_viewH, 0);
            break;
    }
}





- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enventForDismiss)]];
    }
    return _maskView;
}

@end
