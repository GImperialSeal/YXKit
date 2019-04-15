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

typedef enum : NSInteger{
    GSettingItemTypeDefault,      // 什么也没有
    GSettingItemTypeSwitch,    // 开关
    GSettingItemTypeSignout,   // 退出
    GSettingItemTypeValue1, // 头像
    GSettingItemTypeTextField,    // 输入
    GSettingItemTypeCustom,     // 自定义

} GSettingItemType;

typedef void(^CellBlock)(YXSettingItem *item);
typedef void(^SwitchBlock)(BOOL on);
typedef void(^EditBlock)(NSString *text);
typedef void(^AccessoryViewBlock)(UIButton *sender);

@interface YXSettingItem : NSObject

// default
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) UIColor *subTitleColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *subtitleFont;

// textfield
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic) UIKeyboardType keyType;
@property (nonatomic) NSInteger limitEditLength;

// signout
@property (nonatomic, strong) UIColor *signoutBGColor;
@property (nonatomic, strong) UIColor *signoutButtonTitleColor;

// switch
@property (nonatomic) BOOL switchDefaultState;

// cell
@property (nonatomic, strong) UIColor *backCellViewColor;
@property (nonatomic) BOOL showDisclosureIndicator;
@property (nonatomic) CGFloat rowHeight;

@property (nonatomic, assign) GSettingItemType type;// Cell的样式

// accessoryview
@property (nonatomic, strong) NSString *accessoryNormalIcon ;// Cell的样式
@property (nonatomic, strong) NSString *accessorySelectedIcon ;// Cell的样式
@property (nonatomic) NSInteger selectedRow ;// Cell的样式

// op
@property (nonatomic, copy) CellBlock cellBlock ; // 点击cell后要执行的操作
@property (nonatomic, copy) SwitchBlock switchBlock;/** cell上开关的操作事件 */
@property (nonatomic, copy) EditBlock editBlock;/** cell上开关的操作事件 */


+ (instancetype)itemTypeDefault:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle cellBlock:(CellBlock)block;
+ (instancetype)itemTypeValue1:(NSString *)title subtitle:(NSString *)subtitle cellBlock:(CellBlock)block;
+ (instancetype)itemTypeTextField:(NSString *)title placeholder:(NSString *)placeholder editBlock:(EditBlock)block;
+ (instancetype)itemTypeSignout:(NSString *)title cellBlock:(CellBlock)block;
@end
