//
//  UIButton+AZBadge.h
//  MGPlayerDemo
//
//  Created by Alfred Zhang on 2018/2/12.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AZBadge)

@property (nonatomic, strong) UILabel *az_btnBadge;
@property (nonatomic, assign) NSInteger az_btnBadgeValue;
@property (nonatomic, copy) NSString *az_btnBadgeText;
@property (nonatomic, assign) BOOL az_btnShowBadge;


@end
