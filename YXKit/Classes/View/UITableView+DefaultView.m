//
//  UITableView+DefaultView.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/4.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "UITableView+DefaultView.h"
#import <objc/message.h>
#import "Masonry.h"
#import "YXResources.h"
#import "YYKit.h"
@implementation UITableView (DefaultView)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalSel = class_getInstanceMethod(self, @selector(reloadData));
        Method currentSel = class_getInstanceMethod(self, @selector(yx_reloadData));
        method_exchangeImplementations(originalSel, currentSel);
    });
}

- (void)yx_reloadData{
    [self yx_reloadData];
    
    // 获取数据源
    id <UITableViewDataSource> dataSource = self.dataSource;
    
    // 获取区的数目
    NSInteger section = [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]?[dataSource numberOfSectionsInTableView:self]:1;
    
    // 计算所有分区的行数加起来的数目
    NSInteger r = 0;
    for (int i = 0; i<section; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];
        r += rows;
    }
    // 多个分区暂时不处理
    if (!r) {
        [self insertSubview:self.defaltView atIndex:0];
    }else{
        [self.defaltView removeFromSuperview];
    }
}

- (void)setDefaltView:(UIView *)defaltView{
    objc_setAssociatedObject(self, @selector(defaltView), defaltView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)defaltView{
    UIView *v = objc_getAssociatedObject(self, _cmd);
    if (!v) {
        v = [[UIView alloc]initWithFrame:self.bounds];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [YXResources imageNamed:@"空页面"];
        [v addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"空空如也～";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithHexString:@"#AAAAAA"];
        label.tag = 100;
        [v addSubview:label];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(-80);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(imageV.mas_bottom).offset(8);
        }];
        
        [self setDefaltView:v];
//        v.backgroundColor = [UIColor orangeColor];
    }
    return v;
}

- (void)setShowDefaultView:(BOOL)showDefaultView{
    objc_setAssociatedObject(self, @selector(showDefaultView), @(showDefaultView), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)showDefaultView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];

}

- (void)setShow:(BOOL)show{
    self.defaltView.hidden = !show;
}

- (void)remove{
    UIView *v = objc_getAssociatedObject(self, _cmd);
    if (v) {
        [v removeFromSuperview];
    }
}

- (void)setTitle:(NSString *)title{
    [(UILabel *)[self.defaltView viewWithTag:100] setText:title];
}
@end
