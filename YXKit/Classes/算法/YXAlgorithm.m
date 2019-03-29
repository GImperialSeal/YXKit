//
//  YXAlgorithm.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/29.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "YXAlgorithm.h"

@implementation YXAlgorithm


// 冒泡排序
+ (NSMutableArray *)sortByBubble:(NSArray *)tempArray isAscending:(BOOL)ascending{
    NSMutableArray *arr = tempArray.mutableCopy;
    for (int i = 0; i<arr.count; i++) {
        for (int j = 0; j<arr.count-1-i; j++) {
            //小到大
            if (ascending) {
                if ([arr[j] integerValue] > [arr[j+1] integerValue]) {
                    [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }else{
            //大到小
                if ([arr[j] integerValue] < [arr[j+1] integerValue]) {
                    [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
    return arr;
}

// 选择排序
+ (NSMutableArray *)sortBySection:(NSArray *)tempArray isAscending:(BOOL)ascending{
    NSMutableArray *arr = tempArray.mutableCopy;
    for (int i = 0; i<arr.count; i++) {
        for (int j = i+1; j<tempArray.count; j++) {
            if (ascending) {
                if ([arr[i] integerValue]>[arr[j] integerValue]) {
                    [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }else{
                if ([arr[i] integerValue]<[arr[j] integerValue]) {
                    [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
    }
    return arr;
}




@end
