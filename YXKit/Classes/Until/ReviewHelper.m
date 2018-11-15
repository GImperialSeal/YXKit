//
//  ReviewHelper.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/14.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "ReviewHelper.h"
@import StoreKit;
@implementation ReviewHelper

+ (void)review:(NSString *)appID{
    NSURL *appReviewUrl = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",appID]];//换成你应用的 APPID
    if (@available(iOS 10.3,*)) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:appReviewUrl options:@{} completionHandler:nil];
    }else{
        [[UIApplication sharedApplication] openURL:appReviewUrl];
    }
   
}

+ (BOOL)canReviewStar{
    return [SKStoreReviewController respondsToSelector:@selector(requestReview)];
}
    
+ (void)reviewStar{
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        [SKStoreReviewController requestReview];
    }
}
@end
