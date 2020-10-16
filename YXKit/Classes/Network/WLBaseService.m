//
//  AIBaseViewModel.m
//  AIStock
//
//  Created by 顾玉玺 on 2019/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

#import "WLBaseService.h"
#import <YYKit/YYKit.h>
#import <AFNetworking.h>
#import "YXMacro.h"
//#import <MBProgressHUD.h>
//#import "CommonHelper.h"
//#import "AccountManager.h"

static NSString * const kAPICustomErrorDomain = @"kAPPAPICustomErrorDomain";


@implementation WLBaseService

- (void)configContentTypes{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
//    [YTKNetworkConfig.sharedConfig setBaseUrl:self.baseUrl];
    self.header = [NSMutableDictionary dictionary];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configContentTypes];
        self.cacheTime = 0;
        self.method = YTKRequestMethodPOST;
        self.responseType = YTKResponseSerializerTypeJSON;
        self.requestType = YTKRequestSerializerTypeJSON;
//        self.header = [[AccountManager sharedManager].apiHeader mutableCopy];
        self.showErrorToast = YES;
        self.timeoutInterval = 30;
    }
    return self;
}

- (NSTimeInterval)requestTimeoutInterval{
    return self.timeoutInterval;
}

+ (instancetype)api{
    return [[self alloc] init];
}

- (void)setBody:(id)body{
    _body = body;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",YTKNetworkConfig.sharedConfig.baseUrl,self.requestUrl];
    //创建请求
    NSMutableURLRequest *requst = [[AFJSONRequestSerializer serializer]
                                   requestWithMethod:@"POST"
                                   URLString:url
                                   parameters:self.requestArgument
                                   error:nil];
    requst.timeoutInterval = 30;
    requst.HTTPBody = [body modelToJSONData];
    self.customRequest = requst;
}


// 处理登录异常, 文本提示, 数据分页
- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    __weak typeof(self)weakself = self;
    [self setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself printLog];
        weakself.result = [WLBaseResultModel modelWithJSON:request.responseJSONObject];
        [weakself responseHandle:success failure:failure];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself printLog];
        weakself.status = WLRequestStatusNotReachable;
        !failure?:failure(request);
    }];
    [self start];
}


/**
 请求参数中携带 sid
 */
- (id)requestArgument{
//    if (self.param.count>0) {
//        return nil;
//    }else{
//        return [EncryptionHelper encryptWithParams:self.param];
//    }
    return self.param;
}
//- (NSString *)baseUrl{
//    return APIBaseURL();
//}



- (YTKResponseSerializerType)responseSerializerType{
    return self.responseType;
}
- (YTKRequestSerializerType)requestSerializerType{
    return self.requestType;
}
- (YTKRequestMethod)requestMethod{
    return self.method;
}

- (NSString *)requestUrl{
    return self.url;
}
- (NSInteger)cacheTimeInSeconds{
    return self.cacheTime;
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return self.header;
}
- (NSURLRequest *)buildCustomUrlRequest{
    return self.customRequest;
}
@end

@implementation WLBaseService(handle)


- (NSError *)analysisError{
    NSError *error = errorBuild(self.result.code, kAPICustomErrorDomain, self.result.msg);
    return error;
}

- (void)printLog{
    #if DEBUG
            NSLog(@"...........\n url:%@\n argument: %@\n  response: \n%@ \n................",self.originalRequest.URL,self.requestArgument,self.responseString);
    #else
    
    #endif
}
- (void)responseHandle:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    if (self.result) {
//        if (self.result.code == ServiceErrorCode_Success) {
//            self.status = WLRequestStatusSuccess;
//            !success?:success(self);
//        }else{
//            self.status = WLRequestStatusError;
//            if (self.result.code == ServiceErrorCode_UnLogin) {
////                [[AccountManager sharedManager] logout];
////                [URLRouter routerUrlWithPath:kURLRouter_CheckLogin];
//            }else{
//                if (self.showErrorToast) {
////                    [ToastHelper showMessage:self.result.msg];
//                }
//            }
            !failure?:failure(self);
//        }
    }
}

@end



