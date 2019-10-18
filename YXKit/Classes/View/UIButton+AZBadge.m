//
//  UIButton+AZBadge.m
//  MGPlayerDemo
//
//  Created by Alfred Zhang on 2018/2/12.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import "UIButton+AZBadge.h"
#import <objc/runtime.h>
#import "Masonry.h"

@implementation UIButton (AZBadge)
//
//static void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
//
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}
//
//
//+ (void)load {
//    SEL originalSelector = @selector(initWithFrame:);
//    SEL swizzledSelector = @selector(az_btnInitWithFrame:);
//    swizzleMethod([self class], originalSelector, swizzledSelector);
//}
//
//- (instancetype)az_btnInitWithFrame:(CGRect)frame {
//    UIButton *btn = [self az_btnInitWithFrame:frame];
//    [btn addSubview:self.az_btnBadge];
//
//    return btn;
//}


#pragma mark- getter & setter

- (NSInteger)az_btnBadgeValue {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setAz_btnBadgeValue:(NSInteger)az_btnBadgeValue {
    objc_setAssociatedObject(self, @selector(az_btnBadgeValue), @(az_btnBadgeValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.az_btnBadge.text = [NSString stringWithFormat:@"%ld",(long)az_btnBadgeValue];
}

- (NSString *)az_btnBadgeText {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAz_btnBadgeText:(NSString *)az_btnBadgeText {
    objc_setAssociatedObject(self, @selector(az_btnBadgeText), az_btnBadgeText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.az_btnBadge.text = az_btnBadgeText;
}

- (UILabel *)az_btnBadge {
    UILabel *view = objc_getAssociatedObject(self, _cmd);
    if (view == nil) {
        view = [[UILabel alloc] init];
        view.textAlignment = NSTextAlignmentCenter;
        view.backgroundColor = [UIColor colorWithRed:251/255.0 green:93/255.0 blue:95/255.0 alpha:1/1.0];
        view.textColor = [UIColor whiteColor];
        view.font = [UIFont systemFontOfSize:11];
        view.layer.cornerRadius = 17 /2.f;
        view.clipsToBounds = YES;
        view.hidden = YES;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(17);
            make.centerY.equalTo(self.titleLabel.mas_top);
            if ([self.titleLabel.text length]>0) {
                make.centerX.equalTo(self.titleLabel.mas_right);
            }else{
                make.centerX.equalTo(self.imageView.mas_right);
            }
            
            make.width.mas_greaterThanOrEqualTo(17);
        }];
        [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        self.az_btnBadge = view;
    }
    return view;
}

- (void)setAz_btnBadge:(UILabel *)az_btnBadge {
    objc_setAssociatedObject(self, @selector(az_btnBadge), az_btnBadge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)az_btnShowBadge {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAz_btnShowBadge:(BOOL)az_btnShowBadge {
    self.az_btnBadge.hidden = !az_btnShowBadge;
    objc_setAssociatedObject(self, @selector(az_btnShowBadge), @(az_btnShowBadge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
