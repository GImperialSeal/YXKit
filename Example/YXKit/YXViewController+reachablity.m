//
//  YXViewController+reachablity.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/14.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXViewController+reachablity.h"
#import "AFNetworking.h"
@implementation YXViewController (reachablity)
- (void)startMonitoring{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"status: %d",status);
    }];
    
    [manager startMonitoring];

}
@end
