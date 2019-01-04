//
//  NetworkManager.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/13.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NetworkManager.h"
#import <YYKit.h>
@implementation NetworkManager

- (void)configContentTypes{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configContentTypes];
    }
    return self;
}

- (void)start:(void (^)(id _Nonnull))success failure:(dispatch_block_t)failure{
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        success(request.responseString);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}


- (YTKRequestMethod)requestMethod{
    return self.method;
}
- (id)requestArgument{
    return self.param;
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
