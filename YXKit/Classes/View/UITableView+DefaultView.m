//
//  UITableView+DefaultView.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/4.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "UITableView+DefaultView.h"
#import <objc/message.h>
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
    if (!r) {
        [self addSubview:self.defaltView];
    }else{
        [self.defaltView removeFromSuperview];
    }
    

    NSLog(@"r: %ld", (long)r);
}

- (void)setDefaltView:(UIView *)defaltView{
    objc_setAssociatedObject(self, @selector(defaltView), defaltView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)defaltView{
    UIView *v = objc_getAssociatedObject(self, _cmd);
    if (!v) {
        v = [[UIView alloc]initWithFrame:self.bounds];
        v.backgroundColor = [UIColor orangeColor];
    }
    return v;
}
@end
