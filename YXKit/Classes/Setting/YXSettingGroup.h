//
//  ZFSettingGroup.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface YXSettingGroup : NSObject
@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, copy) NSString *footer; // 尾部标题
@property (nonatomic, copy) NSString *subtitle; // 尾部标题
@property (nonatomic, copy) NSString *desc; // 小字说明

@property (nonatomic) CGFloat heightForFooter;
@property (nonatomic) CGFloat heightForHeader;
@property (nonatomic) CGFloat heightForRow;
@property (nonatomic) NSInteger index;

@property (nonatomic) BOOL hidden;

@property (nonatomic) BOOL showArrow;
@property (nonatomic) BOOL limit;

@property (nonatomic, strong) NSMutableArray *items; // 中间的条目

+ (instancetype)groupWithItem:(NSArray *)items;


@property (nonatomic, strong) NSDictionary *actionDict;

@end
