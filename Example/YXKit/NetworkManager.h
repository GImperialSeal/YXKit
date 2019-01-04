//
//  NetworkManager.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/13.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN
@interface NetworkManager<T> : YTKRequest

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *header;
@property (nonatomic, strong) NSURLRequest * customRequest;

@property (nonatomic) NSInteger cacheTime;//
@property (nonatomic) BOOL useCache;
@property (nonatomic) YTKRequestMethod method;
@property (nonatomic) YTKRequestSerializerType serializerType;

- (void)start:(void(^)(T obj))success failure:(dispatch_block_t)failure;
@end

NS_ASSUME_NONNULL_END
