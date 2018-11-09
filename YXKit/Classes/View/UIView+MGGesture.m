//
//  UIView+MGGesture.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/23.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "UIView+MGGesture.h"
#import <objc/runtime.h>
@interface UIView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) PanGestureDirection panDirection;
@property (nonatomic, assign) CGFloat panDistance;

@property (nonatomic, copy) EnventBlockForDoubleTap doubleTapBlock;
@property (nonatomic, copy) EnventBlockForSingleTap singleTapBlock;
@property (nonatomic, copy) EnventBlockForPanBeganMoved panBeganMovedBlock;
@property (nonatomic, copy) EnventBlockForPanMoving panMovingBlock;
@property (nonatomic, copy) EnventBlockForPanEndMoved panEndMovedBlock;

@end

@implementation UIView (MGGesture)

//+(void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL originalSelector = @selector(customInit);
//        SEL swizzledSelector = @selector(gesture_customInit);
//        swizzleMethod([self class], originalSelector, swizzledSelector);
//    });
//}
//
// 添加手势
- (void)gesture_customInit {
    [self gesture_customInit];
    [self addGestureRecognizer:self.tapGesture];
    [self addGestureRecognizer:self.doubleTapGesture];
    [self addGestureRecognizer:self.panGesture];
}

// 自动打开视图交互
- (void)openUserInteraction{
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
}

// single tap  delegate  block
- (void)addGestureForSingleTapWithDelegate:(id<MGGestureDelegate>)delegate{
    self.gestureDelagate = delegate;
    [self openUserInteraction];
    [self addGestureRecognizer:self.tapGesture];
}

- (void)addGestureForSingleTapWithBLock:(EnventBlockForSingleTap)singleTapBlock{
    self.singleTapBlock = singleTapBlock;
    [self openUserInteraction];
    [self addGestureRecognizer:self.tapGesture];
}

- (void)addGestureForDoubleTapWithDelegate:(id<MGGestureDelegate>)delegate{
    self.gestureDelagate = delegate;
    [self openUserInteraction];
    [self addGestureRecognizer:self.doubleTapGesture];
}
- (void)addGestureForDoubleTapWithBlock:(EnventBlockForDoubleTap)doubleTapBlock{
    self.doubleTapBlock = doubleTapBlock;
    [self openUserInteraction];
    [self addGestureRecognizer:self.doubleTapGesture];
}


// pan  delegate  blok
- (void)addGestureForPanWithDelegate:(id<MGGestureDelegate>)delegate{
    self.gestureDelagate = delegate;
    [self openUserInteraction];
    [self addGestureRecognizer:self.panGesture];
}

- (void)addGestureForPanWithBlock:(EnventBlockForPanBeganMoved)began moving:(EnventBlockForPanMoving)moving end:(EnventBlockForPanEndMoved)end{
    self.panBeganMovedBlock = began;
    self.panMovingBlock = moving;
    self.panEndMovedBlock = end;
    [self openUserInteraction];
    [self addGestureRecognizer:self.panGesture];

}

#pragma mark- gesture action

- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    if ([self.gestureDelagate respondsToSelector:@selector(enventForSingleTap:)]) {
        [self.gestureDelagate enventForSingleTap:sender.view];
    }
    if (self.singleTapBlock) {
        self.singleTapBlock([sender locationInView:self]);
    }
}

- (void)doubleTapGestureAction:(UITapGestureRecognizer *)sender {
    if ([self.gestureDelagate respondsToSelector:@selector(enventForDoubleTap:)]) {
        [self.gestureDelagate enventForDoubleTap:sender.view];
    }
    if (self.doubleTapBlock) {
        self.doubleTapBlock(sender.view);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}


- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    //根据在view上Pan的位置，确定是调音量还是亮度
    CGPoint locationPoint = [pan locationInView:self];
    
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self];
    
    static BOOL isFinish = NO;
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
            isFinish = YES;
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) { // 水平移动
                self.panDirection = PanDirectionHorizontalMoved;
            }
            else if (x < y){ // 垂直移动
                self.panDirection = PanDirectionVerticalMoved;
                if (locationPoint.x > self.bounds.size.width / 2) { // 右侧垂直滑动
                    self.panDirection = self.panDirection | PanDirectionRightMoved;
                }else { // 左侧垂直滑动
                    self.panDirection = self.panDirection | PanDirectionLeftMoved;
                }
            }
            if ([self.gestureDelagate respondsToSelector:@selector(enventForPanStateBeganMoved:direction:)]) {
                [self.gestureDelagate enventForPanStateBeganMoved:self direction:self.panDirection];
            }
            if (self.panBeganMovedBlock) {
                self.panBeganMovedBlock(pan.view, self.panDirection);
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在滑动
            CGFloat value = 0;
            if (self.panDirection & PanDirectionVerticalMoved) { // 垂直滑动
                value = veloctyPoint.y;
            }else { // 水平滑动
                value = veloctyPoint.x;
            }
            if ([self.gestureDelagate respondsToSelector:@selector(enventForPanStateMoving:direction:value:)]) {
                [self.gestureDelagate enventForPanStateMoving:self direction:self.panDirection value:value];
            }
            if (self.panMovingBlock) {
                self.panMovingBlock(pan.view, self.panDirection, value);
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            if (!isFinish) {
                break;
            }
            isFinish = NO;
            
            if ([self.gestureDelagate respondsToSelector:@selector(enventForPanStateEndMoved:direction:)]) {
                [self.gestureDelagate enventForPanStateEndMoved:self direction:self.panDirection];
            }
            if (self.panEndMovedBlock) {
                self.panEndMovedBlock(pan.view, self.panDirection);
            }
            break;
        }
        default:
            break;
    }
}



- (id<MGGestureDelegate>)gestureDelagate {
    return objc_getAssociatedObject(self, _cmd);
}
// 单击
- (UITapGestureRecognizer *)tapGesture {
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, _cmd);
    if (tap == nil) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        tap.delegate = self;
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [tap requireGestureRecognizerToFail:self.doubleTapGesture];
        self.tapGesture = tap;
    }
    return tap;
}

// 双击
- (UITapGestureRecognizer *)doubleTapGesture {
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, _cmd);
    if (tap == nil) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureAction:)];
        tap.numberOfTapsRequired = 2;
        tap.delegate = self;
        tap.numberOfTouchesRequired = 1;
        self.doubleTapGesture = tap;
    }
    return tap;
}

// 拖动
- (UIPanGestureRecognizer *)panGesture {
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, _cmd);
    if (pan == nil) {
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.delegate = self;
        self.panGesture = pan;
    }
    return pan;
}

// 拖动方向
- (PanGestureDirection)panDirection {
    NSNumber *direction = objc_getAssociatedObject(self, _cmd);
    return [direction integerValue];
}

// 拖动距离
- (CGFloat)panDistance {
    NSNumber *panDistance = objc_getAssociatedObject(self, _cmd);
    return [panDistance floatValue];
}

- (EnventBlockForSingleTap)singleTapBlock{
    return objc_getAssociatedObject(self, _cmd);;
}
- (EnventBlockForDoubleTap)doubleTapBlock{
    return objc_getAssociatedObject(self, _cmd);;
}
- (EnventBlockForPanBeganMoved)panBeganMovedBlock{
    return objc_getAssociatedObject(self, _cmd);;
}
- (EnventBlockForPanMoving)panMovingBlock{
    return objc_getAssociatedObject(self, _cmd);;
}
- (EnventBlockForPanEndMoved)panEndMovedBlock{
    return objc_getAssociatedObject(self, _cmd);;
}

#pragma mark- setter
- (void)setGestureDelagate:(id<MGGestureDelegate>)gestureDelagate {
    objc_setAssociatedObject(self, @selector(gestureDelagate), gestureDelagate, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture {
    objc_setAssociatedObject(self, @selector(tapGesture), tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDoubleTapGesture:(UITapGestureRecognizer *)doubleTapGesture {
    objc_setAssociatedObject(self, @selector(doubleTapGesture), doubleTapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPanGesture:(UIPanGestureRecognizer *)panGesture {
    objc_setAssociatedObject(self, @selector(panGesture), panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPanDirection:(PanGestureDirection)panDirection {
    objc_setAssociatedObject(self, @selector(panDirection), [NSNumber numberWithInteger:panDirection], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPanDistance:(CGFloat)panDistance {
    objc_setAssociatedObject(self, @selector(panDistance), [NSNumber numberWithInteger:panDistance], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSingleTapBlock:(EnventBlockForSingleTap)singleTapBlock{
    objc_setAssociatedObject(self, @selector(singleTapBlock), singleTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setDoubleTapBlock:(EnventBlockForDoubleTap)doubleTapBlock{
    objc_setAssociatedObject(self, @selector(doubleTapBlock), doubleTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setPanBeganMovedBlock:(EnventBlockForPanBeganMoved)panBeganMovedBlock{
    objc_setAssociatedObject(self, @selector(panBeganMovedBlock), panBeganMovedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setPanMovingBlock:(EnventBlockForPanMoving)panMovingBlock{
    objc_setAssociatedObject(self, @selector(panMovingBlock), panMovingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setPanEndMovedBlock:(EnventBlockForPanEndMoved)panEndMovedBlock{
    objc_setAssociatedObject(self, @selector(panEndMovedBlock), panEndMovedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
