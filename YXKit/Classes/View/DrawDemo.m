//
//  DrawView.m
//  wewef
//
//  Created by 顾玉玺 on 2018/5/8.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "DrawView.h"
// 参考网址
// http://www.cocoachina.com/ios/20160214/15251.html
@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self draw:frame];
    }
    return self;
}
static CAShapeLayer *_shape = nil;
- (void)draw:(CGRect)rect{
    
    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    
    shape.frame = rect;
    
    // 填充色
    shape.fillColor = [UIColor clearColor].CGColor;
    
    // 边框色
    shape.strokeColor = [UIColor whiteColor].CGColor;

    [self.layer addSublayer:shape];
    
    // 绘制矩形
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:rect];
    shape.path = path1.CGPath;
    
    // 圆角矩形
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:3];
    shape.path = path2.CGPath;
    
    // 画圆
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:self.center radius:60 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shape.path = path3.CGPath;
    
    // 画曲线
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(20, 200)];// 开始的点
    //[path4 addQuadCurveToPoint:CGPointMake(300, 200) controlPoint:CGPointMake(100, 100)];
    [path4 addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(160, 100) controlPoint2:CGPointMake(230, 300)];
    shape.path = path4.CGPath;
    
    _shape = shape;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self animation3];

}

- (void)animation1{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2.f;
    [_shape addAnimation:animation forKey:@""];
}

- (void)animation2{
    _shape.strokeStart = 0.5;
    _shape.strokeEnd = 0.5;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.fromValue = @0.5f;
    animation.toValue = @0;
    animation.duration = 2.f;
    [_shape addAnimation:animation forKey:@""];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.fromValue = @0.5;
    animation1.toValue = @1.f;
    animation1.duration = 2.f;
    [_shape addAnimation:animation1 forKey:@""];

}

- (void)animation3{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation1.fromValue = @1;
    animation1.toValue = @10.f;
    animation1.duration = 2.f;
    [_shape addAnimation:animation1 forKey:@""];
}


@end
