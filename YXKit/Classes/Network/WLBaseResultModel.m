//
//  WLBaseModel.m
//  wlive
//
//  Created by Fane on 2020/8/6.
//  Copyright © 2020 wcsz. All rights reserved.
//

#import "WLBaseResultModel.h"

@implementation WLBaseResultModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"desc":@[@"desc",@"description"],
        @"ID":@[@"id"],
        @"list":@[@"data.list",@"data.dataList"]
    };
}

- (NSArray *)list{
    if (!_list) {
        if ([self.data isKindOfClass:NSArray.class]) {
            return self.data;
        }else{
            return nil;
        }
    }
    return _list;
}

@end
