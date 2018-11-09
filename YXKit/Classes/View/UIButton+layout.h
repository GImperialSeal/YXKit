//
//  UIButton+layout.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/3/29.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (layout)

- (void)layoutButtonTopImageBottomWithOffset:(CGFloat)offset;


/**
 左文右图
 */
- (void)layoutButtonLeftTextRightImage;

@end
