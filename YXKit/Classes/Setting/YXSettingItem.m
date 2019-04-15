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

+ (instancetype)itemTypeDefault:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle cellBlock:(CellBlock)block{
    YXSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.subtitle = subtitle;
    item.type = GSettingItemTypeDefault;
    item.showDisclosureIndicator = YES;
    item.cellBlock = block;
    return item;
}

+ (instancetype)itemTypeValue1:(NSString *)title subtitle:(NSString *)subtitle cellBlock:(CellBlock)block{
    YXSettingItem *item = [[self alloc] init];
    item.title = title;
    item.type = GSettingItemTypeValue1;
    item.subtitle = subtitle;
    item.showDisclosureIndicator = YES;
    item.cellBlock = block;
    return item;
}

+ (instancetype)itemTypeTextField:(NSString *)title placeholder:(NSString *)placeholder editBlock:(EditBlock)block{
    YXSettingItem *item = [[self alloc] init];
    item.title = title;
    item.placeholder = placeholder;
    item.limitEditLength = INT_MAX;
    item.type = GSettingItemTypeTextField;
    item.editBlock = block;
    return item;
}


+ (instancetype)itemTypeSignout:(NSString *)title cellBlock:(CellBlock)block{
    YXSettingItem *item = [[self alloc] init];
    item.title = title;
    item.type = GSettingItemTypeSignout;
    item.cellBlock = block;
    return item;
}



- (instancetype)init{
    if ([super init]) {
      
        self.rowHeight = 44;
        self.backCellViewColor = [UIColor redColor];
    }
    
    return self;
}
@end
