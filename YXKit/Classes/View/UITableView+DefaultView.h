//
//  UITableView+DefaultView.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/4.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (DefaultView)

@property (nonatomic, strong)UIView *defaltView;

// 是佛显示
@property (nonatomic)BOOL showDefaultView;

/**
 默认 yes
 */
- (void)setShow:(BOOL)show;


/**
 显示的文字
 */
- (void)setTitle:(NSString *)title;

- (void)remove;


@end

NS_ASSUME_NONNULL_END
