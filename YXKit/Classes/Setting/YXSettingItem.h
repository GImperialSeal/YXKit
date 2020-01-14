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
    YXTableViewCellStyleDefault,
    YXTableViewCellStyleValue1,
    YXTableViewCellStyleValue2,
    YXTableViewCellStyleSubtitle,
    YXTableViewCellStyleValue3, // value3 主标题和副标题紧挨着, 副标题会换行显示, 上下间距是 12
    YXTableViewCellStyleValue3_fit, // value3 主标题和副标题紧挨着, 上下间距是8
    YXTableViewCellStyleValue4, // value4 主标题和副标题紧挨着, 主标题会换行显示
    YXTableViewCellStyleTextField,    // 输入
    YXTableViewCellStyleNineBox,     // 九宫格
    YXTableViewCellStyleInput,   // 正方形输入框带插入图片
    YXTableViewCellStyleTextView,   // 输入框
    YXTableViewCellStyleSelected,   // 有一个选择框
    YXTableViewCellStyleSlider,  // 拖动进度
    YXTableViewCellStylePicker,     // 选择照片
    YXTableViewCellStyleCustom,     // 自定义
} YXTableViewCellStyle;


typedef void(^CellBlock)(YXSettingGroup *group,YXSettingItem *item,NSIndexPath *indexPath);
typedef void(^EditBlock)(NSString *text);
typedef void(^AccessoryViewBlock)(UIButton *sender);
typedef void(^PickerImagesBlock)(NSString *filesIDArray);
typedef void(^PickerDeleteBlock)(NSString *url);
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
@property (nonatomic, strong)YXSettingItem * (^setType)(YXTableViewCellStyle type);
@property (nonatomic, strong)YXSettingItem * (^setRowHeight)(CGFloat height);
@property (nonatomic, strong)YXSettingItem * (^setHideSeparatorLine)(BOOL hide);
@property (nonatomic, strong)YXSettingItem * (^setAccessoryType)(AccessoryType type);
@property (nonatomic, strong)YXSettingItem * (^setCellBlock)(CellBlock block);
@property (nonatomic, strong)YXSettingItem * (^setScrollEnabled)(BOOL enable);


@property (nonatomic)YXTableViewCellStyle style;

@property (nonatomic, strong)NSString *reuseIdentifier;

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
@property (nonatomic) NSInteger maximumValue;//最大值
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

+ (instancetype)itemTypeSelected;

+ (instancetype)itemTypeTextView;
@end
