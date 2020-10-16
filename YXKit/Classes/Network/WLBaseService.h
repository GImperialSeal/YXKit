//
//  AIBaseViewModel.h
//  AIStock
//
//  Created by 顾玉玺 on 2019/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "WLBaseResultModel.h"

@class WLBaseRefreshService,WLBaseService;
NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    WLRequestStatusRequesting,
    WLRequestStatusSuccess,
    WLRequestStatusError,
    WLRequestStatusEmptyData,
    WLRequestStatusNotReachable,
} WLRequestStatus;

typedef void(^ResponseFailBlock)(NSString * msg);

typedef void(^ResponseSucsBlock)(id model);

typedef void(^SuccessBlock)(WLBaseResultModel *result);

// 使用此类,或者继承此类完成请求
@interface WLBaseService : YTKRequest

+ (instancetype)api;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSDictionary *param;

@property (nonatomic, strong) NSMutableDictionary *header;

@property (nonatomic, strong) NSURLRequest * customRequest;

@property (nonatomic) NSInteger cacheTime;//

@property (nonatomic) NSInteger timeoutInterval;//


@property (nonatomic) BOOL useCache;

@property (nonatomic) YTKRequestMethod method;

@property (nonatomic) YTKRequestSerializerType  requestType;

@property (nonatomic) YTKResponseSerializerType responseType;

@property (nonatomic, strong)id body;

@property (nonatomic) WLRequestStatus status;

@property (nonatomic) BOOL showErrorToast;// 默认yes

@property (nonatomic, strong) WLBaseResultModel *result;

@end

// 内部使用
@interface WLBaseService (handle)

- (NSError *)analysisError;

- (void)printLog;

- (void)responseHandle:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure;

@end




NS_ASSUME_NONNULL_END
