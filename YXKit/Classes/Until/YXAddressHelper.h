//
//  ZWAddressApi.h
//  zw_app
//
//  Created by 顾玉玺 on 2019/5/13.
//  Copyright © 2019年 中维科技. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol YXAddressHelperProtocol <NSObject>

// 名字
@property (nonatomic, strong)NSString *userName;

// 名字的拼音
@property (nonatomic, strong)NSString *namePY;

// 名字的首字母
@property (nonatomic, strong)NSString *firstLetter;

@end
@interface YXAddressHelper : NSObject

// 数据排序
+ (void)sort:(NSArray<YXAddressHelperProtocol> *)arr completion:(void(^)(NSMutableDictionary *dict,NSArray *keys))complete;

// 转拼音
+ (NSString *)transformPY:(NSString *)text;

// 获取首字符
+ (NSString *)getFirstLetter:(NSString *)str;

- (void)getLocalAddressList;

@end

NS_ASSUME_NONNULL_END
