//
//  ZFSettingGroup.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXSettingItem;
@import UIKit;
@interface YXSettingGroup : NSObject

@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, copy) NSString *footer; // 尾部标题
@property (nonatomic, copy) NSString *subtitle; // 尾部标题
@property (nonatomic, copy) NSString *desc; // 小字说明

@property (nonatomic) CGFloat heightForFooter;
@property (nonatomic) CGFloat heightForHeader;
@property (nonatomic) NSInteger index;


@property (nonatomic) NSInteger limitRow;// 默认为-1 -1不隐藏

@property (nonatomic, strong) NSMutableArray *items; // 中间的条目

+ (instancetype)groupWithItem:(NSArray *)items;
- (void)addObject:(YXSettingItem *)obj;
@end
