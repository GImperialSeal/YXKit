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
@interface NetworkManager: YTKRequest

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *header;
@property (nonatomic, strong) NSURLRequest * customRequest;

@property (nonatomic) NSInteger cacheTime;//
@property (nonatomic) BOOL useCache;
@property (nonatomic) YTKRequestMethod method;
@property (nonatomic) YTKRequestSerializerType  requestType;
@property (nonatomic) YTKResponseSerializerType responseType;

@end

@interface NetworkManagerHelper : NSObject
+ (NSString *)wifiName;
+ (BOOL)isNetwork;
+ (BOOL)isWifi;
+ (BOOL)isHotSpot;
@end


@interface AXNetAddress : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *netmask;
@property (nonatomic, strong)NSString *gateway;
@end


NS_ASSUME_NONNULL_END
