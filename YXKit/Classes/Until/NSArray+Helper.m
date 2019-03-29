//
//  NSArray+Helper.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/29.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (Helper)

- (NSArray *)deleteRepeatElementThenSortByKey:(NSString *)key ascending:(BOOL)ascending{
    NSSet *set = [NSSet setWithArray:self];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [set sortedArrayUsingDescriptors:@[sort]];
}


- (NSArray *)deleteRepeatElement{
    // 数组去重
    // 方式1
//    NSArray *array = @[@"1",@"2",@"2",@"1"];
//    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:array.count];
//    for (NSString *str in array) {
//        if (![temp containsObject:str]) {
//            [temp addObject:str];
//        }
//    }
//    NSLog(@"temp: %@",temp);
    
    // 方式2
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:self.count];
//    for (NSString *str in self) {
//        [dic setObject:@"" forKey:str];
//    }
//    NSLog(@"temp: %@",dic.allKeys);
    
    // 方式3
//    NSSet *set = [NSSet setWithArray:self];
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES];
//    [set sortedArrayUsingDescriptors:@[sort]];
//    return set.allObjects;
    
    // 方式4
    return [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
}
@end
