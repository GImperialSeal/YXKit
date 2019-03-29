//
//  YXAlgorithm.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/29.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//https://www.cnblogs.com/ZachRobin/p/7094852.html
@interface YXAlgorithm : NSObject

/*1、冒泡排序：
　　冒泡算法是一种基础的排序算法，这种算法会重复的比较数组中相邻的两个元素。如果一个元素比另一个元素大（小），那么就交换这两个元素的位置。重复这一比较直至最后一个元素。这一比较会重复n-1趟，每一趟比较n-j次，j是已经排序好的元素个数。每一趟比较都能找出未排序元素中最大或者最小的那个数字。这就如同水泡从水底逐个飘到水面一样。冒泡排序是一种时间复杂度较高，效率较低的排序方法。其空间复杂度是O(n)。

　　1, 最差时间复杂度 O(n^2)
　　2, 平均时间复杂度 O(n^2)

　　实现思路
　　1，每一趟比较都比较数组中两个相邻元素的大小
　　2，如果i元素小于i-1元素，就调换两个元素的位置
　　3，重复n-1趟的比较
 
 */
+ (NSMutableArray *)sortByBubble:(NSArray *)tempArray isAscending:(BOOL)ascending;


/*2、选择排序：
　　实现思路：

　　 1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束。
　　 2. i=1
　　 3. 从数组的第i个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设arr[i]为最小，逐一比较，若遇到比之小的则交换）
　　 4. 将上一步找到的最小元素和第i位元素交换。
　　 5. 如果i=n－1算法结束，否则回到第3步
 */

+ (NSMutableArray *)sortBySection:(NSArray *)tempArray isAscending:(BOOL)ascending;


@end

NS_ASSUME_NONNULL_END
