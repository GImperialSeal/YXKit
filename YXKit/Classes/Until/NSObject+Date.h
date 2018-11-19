//
//  NSObject+Date.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/15.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Date)


/**
 计算时间间隔
 @param timeDate 时间戳
 @return 秒
 */
- (NSTimeInterval)yx_timeInterval:(NSDate *)timeDate;


/**
 计算时间间隔
 @param timeDate 时间戳
 @return 刚刚 几分钟前 几天前 等... 字符串
 */
- (NSString *)yx_timeInterval_string:(NSDate *)timeDate;

/**
 时间转字符串
 @param timeDate 时间戳
 @return 12:00:00 或者 12:00
 */
+ (NSString *)yx_date_string:(NSInteger)secound;
@end
