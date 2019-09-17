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
    GSettingItemTypeValue3, // value3 主标题和副标题紧挨着, 副标题会换行显示, 上下间距是 12
    GSettingItemTypeValue3_fit, // value3 主标题和副标题紧挨着, 上下间距是8
    GSettingItemTypeValue4, // value4 主标题和副标题紧挨着, 主标题会换行显示
    GSettingItemTypeTextField,    // 输入
    GSettingItemTypeNineBox,     // 九宫格
    GSettingItemTypeInput,   // 正方形输入框带插入图片
    GSettingItemTypeTextView,   // 输入框
    GSettingItemTypeSelected,   // 有一个选择框
    GSettingItemTypeSlider,  // 拖动进度
    GSettingItemTypePicker,     // 选择照片
    GSettingItemTypeCustom,     // 自定义
    GSettingItemTypeSubtitle,   // 什么也没有
    GSettingItemTypeFullImage,   // 铺满的图
} GSettingItemType;


typedef void(^CellBlock)(YXSettingGroup *group,YXSettingItem *item,NSIndexPath *indexPath);
typedef void(^EditBlock)(NSString *text);
typedef void(^AccessoryViewBlock)(UIButton *sender);
typedef void(^PickerImagesBlock)(NSString *filesIDArray);
typedef void(^PickerDeleteBlock)(NSInteger idx);
typedef void(^SeletedBlock)(BOOL selected);
typedef void(^DeleteBlock)();

typedef UITableViewCellAccessoryType AccessoryType;

@interface YXSettingItem : NSObject

@property (nonatomic, strong)YXSettingItem * (^setUrl)(NSString *url);
@property (nonatomic, strong)YXSettingItem * (^setText)(NSString *text);
@property (nonatomic, strong)YXSettingItem * (^setTitle)(NSAttributedString *title);
@property (nonatomic, strong)YXSettingItem * (^setSubtitle)(NSAttributedString *subtitle);
@property (nonatomic, strong)YXSettingItem * (^setPlaceholder)(NSString *placeholder);
@property (nonatomic, strong)YXSettingItem * (^setKeyType)(UIKeyboardType keytype);
@property (nonatomic, strong)YXSettingItem * (^setLimitEdit)(NSInteger limit);
@property (nonatomic, strong)YXSettingItem * (^setEditBlock)(EditBlock block);
@property (nonatomic, strong)YXSettingItem * (^setType)(GSettingItemType type);
@property (nonatomic, strong)YXSettingItem * (^setRowHeight)(CGFloat height);
@property (nonatomic, strong)YXSettingItem * (^setHideSeparatorLine)(BOOL hide);
@property (nonatomic, strong)YXSettingItem * (^setAccessoryType)(AccessoryType type);
@property (nonatomic, strong)YXSettingItem * (^setCellBlock)(CellBlock block);
@property (nonatomic, strong)YXSettingItem * (^setScrollEnabled)(BOOL enable);


// fullimage
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic)BOOL scrollEnabled;

// default
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSAttributedString *title;
@property (nonatomic, strong) NSAttributedString *subtitle;


@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *subtitleText;

// textfield
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) UIKeyboardType keyType;
@property (nonatomic) NSInteger limitEditLength;
@property (nonatomic, strong) EditBlock editBlock;/** 编辑事件 */


// picker
@property (nonatomic, strong) NSArray *pickerImagesArray;
@property (nonatomic) NSInteger maxImageCount;
@property (nonatomic) BOOL hideHint;
@property (nonatomic, strong) PickerImagesBlock pickerBlock;/** 选择图片 */
@property (nonatomic, strong) PickerDeleteBlock pickerDeleteBlock;/** 删除图片 */


// cell
@property (nonatomic) CGFloat rowHeight;

@property (nonatomic) BOOL isObserveTitle;
@property (nonatomic) BOOL isObserveSubtitle;//副标题是可更改的
@property (nonatomic) BOOL selected;//选中

@property (nonatomic, strong) DeleteBlock deleteBlock;/** 选择图片 */


@property (nonatomic) BOOL hideSeparatorLine;

@property (nonatomic) GSettingItemType type;// Cell的样式

// accessoryview
@property (nonatomic, strong) UIView *accessoryview;// Cell的样式
@property (nonatomic) UITableViewCellAccessoryType accessoryType;


// op
@property (nonatomic, strong) CellBlock cellBlock ; // 点击cell后要执行的操作
@property (nonatomic, strong) SeletedBlock selectedBlock ; // 点击cell后要执行的操作


@property (nonatomic, strong) AccessoryViewBlock accessoryBlock;/** AccessoryView事件 */


+ (instancetype)itemTypeDefault:(NSString *)icon;

+ (instancetype)itemTypeValue1;

+ (instancetype)itemTypeValue3;

+ (instancetype)itemTypeValue3Center;

+ (instancetype)itemTypeValue4;

+ (instancetype)itemTypeCustom;

+ (instancetype)itemTypeNineBox;

+ (instancetype)itemTypeInput;

+ (instancetype)itemTypeSlider;

+ (instancetype)itemTypePicker;

+ (instancetype)itemTypeTextField;

+ (instancetype)itemTypeSubtitle;

+ (instancetype)itemTypeFullImage;

+ (instancetype)itemTypeSelected;

+ (instancetype)itemTypeTextView;
@end
