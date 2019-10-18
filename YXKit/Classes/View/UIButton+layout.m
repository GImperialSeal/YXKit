//
//  UIButton+layout.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/29.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "UIButton+layout.h"

@implementation UIButton (layout)

- (void)layoutButtonTopImageBottomWithOffset:(CGFloat)offset{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, -self.imageView.frame.size.height-offset/2, 0);
    // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height-offset/2, 0, 0, -button.titleLabel.frame.size.width);
    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
    self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -self.titleLabel.intrinsicContentSize.width);
}

- (void)layoutButtonLeftTextRightImage{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width-16 , 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.intrinsicContentSize.width + 16, 0, 0);
}

@end
