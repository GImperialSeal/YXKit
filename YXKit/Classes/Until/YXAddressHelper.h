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
@property (nonatomic, strong)NSString *addressName;

// 名字的拼音
@property (nonatomic, strong)NSString *addressNameNamePY;

// 名字的首字母
@property (nonatomic, strong)NSString *addressFirstLetter;

// 手机号
@property (nonatomic, strong)NSString *addressMoblie;

@end

@interface YXAddressModel : NSObject<YXAddressHelperProtocol>


@end

@interface YXAddressHelper : NSObject

// 数据排序 // originaldatalist 原始数据, 不过包含了拼音 及名字的首字符
+ (void)sort:(NSArray<YXAddressHelperProtocol> *)arr completion:(void(^)(NSMutableDictionary *dict,NSArray *keys,NSArray * originalDataList))complete;

// 转拼音
+ (NSString *)transformPY:(NSString *)text;
// 不带汉字首字符简写的转换
+ (NSString *)transformPY:(NSString *)text needSimplePY:(BOOL)need;

// 获取首字符
+ (NSString *)getFirstLetter:(NSString *)str;

// 获取通讯录
+ (void)getLocalAddressList:(void(^)(NSArray *list))success;

// 是否是中文
+ (BOOL)isChineseWithStr:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
