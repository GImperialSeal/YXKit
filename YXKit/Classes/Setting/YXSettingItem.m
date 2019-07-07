//
//  ZFSettingItem.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "YXSettingItem.h"

@interface YXSettingItem()


@end

@implementation YXSettingItem

+ (instancetype)itemTypeSubtitle{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeSubtitle;
    return item;
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
    item.type = GSettingItemTypeValue3_center;
    return item;
}

+ (instancetype)itemTypeValue3Center{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeValue3;
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

+ (instancetype)itemTypeTextField{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeTextField;
    return item;
}

+ (instancetype)itemTypeCustom{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeCustom;
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
