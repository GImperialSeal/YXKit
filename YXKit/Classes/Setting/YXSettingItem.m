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
        self.rowHeight = 44;
        self.limitEditLength = 500;
        self.accessoryview = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.hideSeparatorLine = YES;
    }
    return self;
}
@end
