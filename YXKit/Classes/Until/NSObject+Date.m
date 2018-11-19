//
//  NSObject+Date.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/15.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NSObject+Date.h"
@implementation NSObject (Date)

- (NSTimeInterval)yx_timeInterval:(NSDate *)timeDate{
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    timeInterval = -timeInterval;
    return timeInterval;
}
- (NSString *)yx_timeInterval_string:(NSDate *)timeDate{
    NSTimeInterval interval = [self yx_timeInterval:timeDate];
    return [self transformTimeIntervalToString:interval];
}



- (NSString *)transformTimeIntervalToString:(NSTimeInterval)timeInterval{
    long temp = 0;
    NSString *time;
    if (timeInterval<60) {
        time = [NSString stringWithFormat:@"刚刚"];
    }else if ((temp = timeInterval/60)<60){
        time = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if ((temp = timeInterval/(60*60))<24){
        time = [NSString stringWithFormat:@"%ld小时前",temp];
    }else if((temp = timeInterval/(24*60*60))<30){
        time = [NSString stringWithFormat:@"%ld天前",temp];
    }else if (((temp = timeInterval/(24*60*60*30)))<12){
        time = [NSString stringWithFormat:@"%ld月前",temp];
    }else {
        temp = timeInterval/(24*60*60*30*12);
        time = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return time;
}

+ (NSString *)yx_date_string:(NSInteger)secound{
    NSInteger hour =  secound / 3600;
    NSInteger minute = (secound % 3600)/60;
    NSInteger per = (secound % 3600)%60;
    NSString *time;
    time = hour>0 ? [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minute,(long)per] :[NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)per];
    return time;
    
}





@end
