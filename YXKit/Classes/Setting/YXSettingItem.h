//
//  ZFSettingItem.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//  一个Item对应一个Cell
// 用来描述当前cell里面显示的内容，描述点击cell后做什么事情

#import <Foundation/Foundation.h>
@import UIKit;
@class YXSettingItem;
@class YXSettingGroup;
typedef enum : NSInteger{
    GSettingItemTypeDefault,   // 什么也没有
    GSettingItemTypeValue1, // value1
    GSettingItemTypeTextField,    // 输入
    GSettingItemTypeCustom,     // 自定义
} GSettingItemType;

typedef void(^CellBlock)(YXSettingGroup *group,YXSettingItem *item,NSIndexPath *indexPath);
typedef void(^SwitchBlock)(BOOL on);
typedef void(^EditBlock)(NSString *text);
typedef void(^AccessoryViewBlock)(UIButton *sender);

@interface YXSettingItem : NSObject

// default
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSAttributedString *title;
@property (nonatomic, strong) NSAttributedString *subtitle;

// textfield
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic) UIKeyboardType keyType;
@property (nonatomic) NSInteger limitEditLength;


// cell
@property (nonatomic) CGFloat rowHeight;
@property (nonatomic) BOOL hideSeparatorLine;

@property (nonatomic) GSettingItemType type;// Cell的样式

// accessoryview
@property (nonatomic, strong) UIView *accessoryview;// Cell的样式
@property (nonatomic) UITableViewCellAccessoryType accessoryType;


// op
@property (nonatomic, strong) CellBlock cellBlock ; // 点击cell后要执行的操作
@property (nonatomic, strong) SwitchBlock switchBlock;/** cell上开关的操作事件 */
@property (nonatomic, strong) EditBlock editBlock;/** 编辑事件 */

@property (nonatomic, strong) AccessoryViewBlock accessoryBlock;/** AccessoryView事件 */

+ (NSAttributedString *)attribute:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;
+ (NSAttributedString *)attributeDefaultTitle:(NSString *)text;
+ (NSAttributedString *)attributeDefaultSubtitle:(NSString *)text;

+ (instancetype)itemTypeDefault:(NSString *)icon;

+ (instancetype)itemTypeValue1;

+ (instancetype)itemTypeCustom;

@end
