//
//  ZFSettingGroup.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "YXSettingGroup.h"

@implementation YXSettingGroup

+ (instancetype)groupWithItem:(NSArray *)items{
    YXSettingGroup *g = [[self alloc]init];
    g.heightForFooter = 10;
    g.heightForHeader = 10;
    g.items = items;
    return g;
}


@end
