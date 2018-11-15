//
//  ReviewHelper.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/14.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewHelper : NSObject
// 跳转APPStore 中应用的撰写评价页面
+ (void)review:(NSString *)appID;

// 五星好评的入口
+ (void)reviewStar;

// 评星
+ (BOOL)canReviewStar;
@end
