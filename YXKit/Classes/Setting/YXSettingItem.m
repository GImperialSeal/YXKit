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

+ (NSAttributedString *)attribute:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color{
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
}

+ (NSAttributedString *)attributeDefaultTitle:(NSString *)text{
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
+ (NSAttributedString *)attributeDefaultSubtitle:(NSString *)text{
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]}];
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

+ (instancetype)itemTypeCustom{
    YXSettingItem *item = [[self alloc] init];
    item.type = GSettingItemTypeCustom;
    return item;
}

- (instancetype)init{
    if ([super init]) {
        self.rowHeight = 44;
        self.accessoryview = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.hideSeparatorLine = YES;
    }
    return self;
}
@end
