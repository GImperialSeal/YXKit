//
//  YXLocationManager.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/27.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXLocationManager : NSObject
- (void)location:(void(^)(NSDictionary *place))complete failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
