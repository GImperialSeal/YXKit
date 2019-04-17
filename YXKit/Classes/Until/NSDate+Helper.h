//
//  NSDate+Helper.h
//  AFNetworking
//
//  Created by 顾玉玺 on 2019/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Helper)
/** 根据日期返回字符串 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

/** 对象方法，返回时间字符串 */
- (NSString *)stringWithFormat:(NSString *)format;

/** 根据字符串返回NSDate */
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

/** 根据TimeInterval获取字符串,带有时区偏移 */
+ (NSString *)stringWithTimeInterval:(unsigned int)time Formatter:(NSString *)format;

/** 根据字符串和格式获取TimeInterval时间,带有时区偏移 */
+ (NSTimeInterval )timeIntervalFromString:(NSString *)timeStr Formatter:(NSString *)format;

/** 当前TimeInterval时间,带有时区偏移 */
+ (NSTimeInterval )now;


/** 获取阴历 */
- (NSString*)lunar;

/** 日期是否相等 */
- (BOOL)isSameDay:(NSDate *)anotherDate;

/** 是否是今天 */
- (BOOL)isToday;



/** 获取英文字符串月份 */
+ (NSString *)monthWithMonthNumber:(NSInteger)month;

/** 获取指定月份的天数 */
- (NSUInteger)daysInMonth:(NSUInteger)month;

/** 获取指定月份的天数 */
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;

/** 获取当前月份的天数 */
- (NSUInteger)daysInMonth;

/** 获取当前月份的天数 */
+ (NSUInteger)daysInMonth:(NSDate *)date;

/** 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前 */
- (NSString *)timeInfo;

/** 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前 */
+ (NSString *)timeInfoWithDate:(NSDate *)date;

/** 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前 */
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;


/**
 时间转字符串
 @return 12:00:00 或者 12:00
 */
+ (NSString *)yx_date_string:(NSInteger)secound;
/*
计算时间间隔
@return 秒
*/
- (NSTimeInterval)yx_timeInterval;

@end

NS_ASSUME_NONNULL_END
