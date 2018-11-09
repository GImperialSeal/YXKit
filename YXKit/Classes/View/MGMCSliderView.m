//
//  MGSliderView.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/23.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "MGMCSliderView.h"
#import "MGMCConfig.h"

#define trackHeight MGScaleValue(2)

@interface MGMCSliderView ()

@property (nonatomic, strong) UIView *maxiTrackView;
@property (nonatomic, strong) UIView *miniTrackView;
@property (nonatomic, strong) UIImageView *thumbImageView;

@end
@implementation MGMCSliderView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumTrackTintColor = KMainColor;
        self.maximumTrackTintColor = [UIColor grayColor];
        self.minimumValue = 0.f;
        self.maximumValue = 1.f;
        self.value = 0;
        
        [self addSubview:self.maxiTrackView];
        [self addSubview:self.miniTrackView];
        [self addSubview:self.shadowImageView];
        [self addSubview:self.thumbImageView];
    }
    return self;
}




- (void)setValue:(CGFloat)value{
    _value = value;
    NSLog(@"vaule: %f",value);
    [self setNeedsLayout];
}

//- (void)setTrackingX:(CGFloat)trackingX{
//    _trackingX = trackingX;
//    CGFloat width = CGRectGetWidth(self.frame);
//    
//    [self setNeedsLayout];
//
////
////    CGFloat x = 0;
////    if (self.value>0) {
////        x = (self.value - self.minimumValue)/(self.maximumValue - self.minimumValue) * width;
////
////    }
//}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
    
    CGFloat width = CGRectGetWidth(self.frame)- self.thumbImage.size.width;
    CGFloat x = 0;
    if (self.value>0) {
        x = (self.value - self.minimumValue)/(self.maximumValue - self.minimumValue) * width;
    }

    if (x>width) {
        x = width;
    }else if (x<0){
        x = 0;
    }
    
    NSLog(@"x:    %02f",x);
    CGFloat height =  CGRectGetHeight(self.frame);
    
    _shadowImageView.frame = CGRectMake(0, 0, x, height);
    
    CGRect rect = _thumbImageView.frame;
    rect.origin.x = x;
    rect.origin.y = (height - rect.size.height)/2;
    
    _thumbImageView.frame = rect;
    _maxiTrackView.frame = CGRectMake(0, (height-trackHeight)/2, width, trackHeight);
    _miniTrackView.frame = CGRectMake(0, (height-trackHeight)/2, x, trackHeight);
}


- (void)updateSliderValue:(UITouch *)touch{
    CGFloat x = [touch locationInView:self].x;
    CGFloat width = CGRectGetWidth(self.frame) - self.thumbImage.size.width;
    if (x<0) {
        self.value = 0;
    }else if (x>width){
        self.value = self.maximumValue;
    }else{
        self.value = [touch locationInView:self].x/width * (self.maximumValue - self.minimumValue) +  self.minimumValue;
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    self.draging = YES;
    NSLog(@"slider: 开始拖动");
    if (self.singleTap) {
        [self updateSliderValue:touch];
    }
    if ([self.delegate respondsToSelector:@selector(sliderBeginTracking:value:)]) {
        [self.delegate sliderBeginTracking:self value:self.value];
    }
    return YES;
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    NSLog(@"slider: 拖动中...");
    [self updateSliderValue:touch];
    
    if ([self.delegate respondsToSelector:@selector(sliderContinueTracking:value:)]) {
        [self.delegate sliderContinueTracking:self value:self.value];
    }
    
  
   
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    self.draging = NO;
    NSLog(@"slider: 结束拖动");
    if (self.singleTap) {
        [self updateSliderValue:touch];
    }
    if ([self.delegate respondsToSelector:@selector(sliderEndTracking:value:)]) {
        [self.delegate sliderEndTracking:self value:self.value];
    }
}



- (void)setThumbImage:(UIImage *)thumbImage{
    _thumbImage = thumbImage;
    self.thumbImageView.image = thumbImage;
    self.thumbImageView.frame = CGRectMake(0, 0, thumbImage.size.width, thumbImage.size.height);
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor{
    _minimumTrackTintColor = minimumTrackTintColor;
    self.miniTrackView.backgroundColor = minimumTrackTintColor;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor{
    _maximumTrackTintColor = maximumTrackTintColor;
    self.maxiTrackView.backgroundColor = maximumTrackTintColor;
}
- (UIImageView *)shadowImageView{
    if (!_shadowImageView) {
        _shadowImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _shadowImageView.userInteractionEnabled = NO;
        _shadowImageView.hidden = YES;
        _shadowImageView.image = [MGMCConfig drawImage:CGRectMake(0, 0, 300, 40) context:^(CGContextRef ctx, CGRect rect) {
            [MGMCConfig drawLinearGradient:ctx rect:rect alpha:0.7 startColor:[UIColor clearColor] endColor:KMainColor];
        }];
    }
    return _shadowImageView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//        _thumbImageView.backgroundColor = UIColorHex(BE9546);
    }
    return _thumbImageView;
}

- (UIView *)maxiTrackView{
    if (!_maxiTrackView) {
        _maxiTrackView=[[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-5)/2, self.frame.size.width, 5)];
        _maxiTrackView.backgroundColor = [UIColor whiteColor];
        _maxiTrackView.userInteractionEnabled = NO;
    }
    return _maxiTrackView;
}

- (UIView *)miniTrackView{
    if (!_miniTrackView) {
        _miniTrackView=[[UIView alloc] initWithFrame:_maxiTrackView.frame];
        _miniTrackView.backgroundColor = [UIColor yellowColor];
        _miniTrackView.userInteractionEnabled = NO;
    }
    return _miniTrackView;
}


@end










