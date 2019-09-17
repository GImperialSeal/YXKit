//
//  ZFSettingItem.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "YXSettingItem.h"
#import <YYKit.h>
@interface YXSettingItem()


@end

@implementation YXSettingItem

- (YXSettingItem *(^)(EditBlock))setEditBlock{
    return ^YXSettingItem *(EditBlock block) {
        self.editBlock = block;
        return self;
    };
}

- (YXSettingItem *(^)(BOOL))setScrollEnabled{
    return ^YXSettingItem *(BOOL h) {
        self.scrollEnabled = h;
        return self;
    };
}

- (YXSettingItem *(^)(CellBlock))setCellBlock{
    return ^YXSettingItem *(CellBlock block) {
        self.cellBlock = block;
        return self;
    };
}

- (YXSettingItem *(^)(UITableViewCellAccessoryType))setAccessoryType{
    return ^YXSettingItem *(UITableViewCellAccessoryType h) {
        self.accessoryType = h;
        return self;
    };
}

- (YXSettingItem *(^)(BOOL))setHideSeparatorLine{
    return ^YXSettingItem *(BOOL h) {
        self.hideSeparatorLine = h;
        return self;
    };
}
- (YXSettingItem *(^)(NSString *))setUrl{
    return ^YXSettingItem *(NSString *url) {
        self.url = url;
        return self;
    };
}

- (YXSettingItem *(^)(CGFloat))setRowHeight{
    return ^YXSettingItem *(CGFloat h) {
        self.rowHeight = h;
        return self;
    };
}

- (YXSettingItem *(^)(NSAttributedString *))setTitle{
    return ^YXSettingItem *(NSAttributedString *title) {
        self.title = title;
        return self;
    };
}

- (YXSettingItem *(^)(NSAttributedString *))setSubtitle{
    return  ^YXSettingItem *(NSAttributedString *subtitle) {
        self.subtitle = subtitle;
        return self;
    };
}

- (YXSettingItem *(^)(NSString *))setPlaceholder{
    return ^YXSettingItem *(NSString *palce) {
        self.placeholder = palce;
        return self;
    };
}

- (YXSettingItem *(^)(UIKeyboardType))setKeyType{
    return ^YXSettingItem *(NSInteger type) {
        self.keyType = type;
        return self;
    };
}

- (YXSettingItem *(^)(NSInteger))setLimitEdit{
    return ^YXSettingItem *(NSInteger type) {
        self.limitEditLength = type;
        return self;
    };
}

- (YXSettingItem *(^)(GSettingItemType))setType{
    return ^YXSettingItem *(GSettingItemType type) {
        self.type = type;
        return self;
    };
}

- (YXSettingItem *(^)(NSString *))setText{
    return ^YXSettingItem *(NSString *text) {
        self.text = text;
        return self;
    };
}

+ (instancetype)itemTypeDefault:(NSString *)icon{
    YXSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.type = GSettingItemTypeDefault;
    return item;
}

+ (instancetype)itemTypeValue1{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeValue1;
    return item;
}
+ (instancetype)itemTypeValue4{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeValue4;
    return item;
}

+ (instancetype)itemTypeFullImage{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeFullImage;
    return item;
}

+ (instancetype)itemTypeValue3{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeValue3;
    return item;
}

+ (instancetype)itemTypeValue3Center{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeValue3_fit;
    return item;
}

+ (instancetype)itemTypeSlider{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeSlider;
    return item;
}

+ (instancetype)itemTypeInput{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeInput;
    return item;
}

+ (instancetype)itemTypeNineBox{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeNineBox;
    return item;
}
+ (instancetype)itemTypePicker{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypePicker;
    item.hideHint = NO;
    item.maxImageCount = 6;
    return item;
}

+ (instancetype)itemTypeSelected{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeSelected;
    return item;
}

+ (instancetype)itemTypeTextField{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeTextField;
    item.isObserveSubtitle = YES;
    return item;
}

+ (instancetype)itemTypeTextView{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeTextView;
    return item;
}

+ (instancetype)itemTypeCustom{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeCustom;
    return item;
}

+ (instancetype)itemTypeSubtitle{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeSubtitle;
    return item;
}

- (instancetype)init{
    if ([super init]) {
        self.rowHeight = UITableViewAutomaticDimension;
        self.limitEditLength = 500;
        self.accessoryview = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.hideSeparatorLine = YES;
    }
    return self;
}



@end

