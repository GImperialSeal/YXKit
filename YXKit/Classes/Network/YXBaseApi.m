//
//  AIBaseViewModel.m
//  AIStock
//
//  Created by 顾玉玺 on 2019/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YXBaseApi.h"
#import <MJRefresh/MJRefresh.h>
#import <YYKit/YYKit.h>
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@implementation YXBaseApi

- (void)configContentTypes{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
    [YTKNetworkConfig.sharedConfig setBaseUrl:self.baseUrl];
    self.header = [NSMutableDictionary dictionary];
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


/**
 请求参数中携带 sid
 */
- (id)requestArgument{
    return self.param;
}

- (void)printLog:(YTKBaseRequest *)request{
    #if DEBUG
            NSLog(@"...........\n url:%@\n argument: %@\n  response: \n%@ \n................",request.originalRequest.URL,request.requestArgument,request.responseString);
    #else
    #endif
}

- (NSString *)baseUrl{
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval{
    return 10;
}
- (void)handleRequest:(YTKBaseRequest *)request success:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    [self printLog:request];
    if ([request.responseObject[@"code"] isEqualToString:@"990010"]) {
        if (!self.isAutoLogin) {
            failure(request);
            return;
        }
      
    }else{
        if ([request.responseObject[@"code"]integerValue] == 0) {
            success(request);
        }else{
            failure(request);
            [self showTextHUD:request];
        }
    }
}

// 处理登录异常, 文本提示, 数据分页
- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    __weak typeof(self)weakself = self;
    [self setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself handleRequest:request success:success failure:failure];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself printLog:request];
        [weakself showTextHUD:@"网络连接失败"];
        !failure?:failure(request);
    }];
    [self start];
}

- (void)showTextHUD:(id)msg{
    if (self.showToast) {
        if ([msg isKindOfClass:YTKBaseRequest.class]) {
//            showToast(((YTKBaseRequest *)msg).responseObject[@"msg"]);
        }else{
//            showToast(msg);
        }
    }
}

- (void)getMainQueue:(dispatch_block_t)block{
    if ([NSThread.currentThread isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

- (void)showProgress{
    if (self.showProgressView) {
        [self getMainQueue:^{
            // 快速显示一个提示信息
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.addedView animated:YES];
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = YES;
            // YES代表需要蒙版效果
        }];
     
       
    }
}

- (UIView *)addedView{
    if (!_addedView) {
        _addedView = [UIApplication sharedApplication].keyWindow;
    }
    return _addedView;
}

- (void)hideProgress{
    if (self.showProgressView) {
        [self getMainQueue:^{
            [MBProgressHUD hideHUDForView:self.addedView animated:YES];
        }];
    }
}



- (instancetype)init{
    self = [super init];
    if (self) {
        [self configContentTypes];
        self.cacheTime = 0;
        self.method = YTKRequestMethodGET;
        self.responseType = YTKResponseSerializerTypeJSON;
        self.showToast = YES;
        self.showProgressView = YES;
//        self.header = @{@"Content-Type":@"application/X-WWW-FORM-URLENCODED"};
    }
    return self;
}

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

@implementation YXBaseRefreshApi

- (void)defaultConfig{
    self.pager = 1;
    self.method = YTKRequestMethodPOST;
//    self.header = @{@"accept":@"application/json"}.mutableCopy;
}

- (instancetype)initRefreshDelegate:(id<YXRefreshProtocol>)delegate{
    self = [super init];
    if (self) {
        [self defaultConfig];
        self.refreshDelegate = delegate;
        self.pageSize = 10;
        __weak typeof(self)weakself = self;
        self.refreshDelegate.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakself.pager = 1;
            [weakself.refreshDelegate networkForListDatas];
        }];
        self.refreshDelegate.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.pager++;
            [weakself.refreshDelegate networkForListDatas];
        }];
        
        [(MJRefreshNormalHeader *)self.refreshDelegate.tableView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
    }
    return self;
}



- (void)setUnRefresh:(BOOL)unRefresh{
    _unRefresh = unRefresh;
    if (_unRefresh) {
        self.refreshDelegate.tableView.mj_header  = nil;
    }
}

- (void)setUnLoadMore:(BOOL)unLoadMore{
    _unLoadMore = unLoadMore;
    if (unLoadMore) {
           self.refreshDelegate.tableView.mj_footer  = nil;
       }
}

- (void)beginRefreshing{
    if (!self.unRefresh) {
        [self.refreshDelegate.tableView.mj_header beginRefreshing];
    }else{
        [self beginRefreshing:NO];
    }
}

- (void)beginRefreshing:(BOOL)animated{
    if (animated) {
        [self.refreshDelegate.tableView.mj_header beginRefreshing];
    }else{
        self.pager = 1;
        [self.refreshDelegate networkForListDatas];
    }
  
}

- (void)reload{
    if (_refreshDelegate) {
        [_refreshDelegate.tableView reloadData];
    }

}
- (void)endRefreshing{
    if (_refreshDelegate) {
        [_refreshDelegate.tableView.mj_header endRefreshing];
        [_refreshDelegate.tableView.mj_footer endRefreshing];
    }
}

// 刷新或者加载更多
- (void)reloadMoreDataWithTotalCount:(NSDictionary *)dic{
    if (!_refreshDelegate) {
        return;
    }
    NSInteger total = [dic[@"data"][@"page"][@"totalCount"] integerValue];
    self.total = total;
    
    if (self.pager == 1) {
        [_refreshDelegate.datas removeAllObjects];
    }
    [self.refreshDelegate.tableView.mj_header endRefreshing];
    if ((self.pager*self.pageSize)>=total) {
        if (self.total>0) {
            [_refreshDelegate.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_refreshDelegate.tableView.mj_footer endRefreshing];
        }
    }else{
        [_refreshDelegate.tableView.mj_footer endRefreshing];
    }
}

// 处理登录异常, 文本提示, 数据分页
- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    __weak typeof(self)weakself = self;
    [self showProgress];
    [self setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself hideProgress];
        [weakself handleRequest:request success:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakself reloadMoreDataWithTotalCount:request.responseObject];
            !success?:success(request);
            [weakself reload];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            !failure?:failure(request);
            [weakself endRefreshing];
        }];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself printLog:request];
        [weakself hideProgress];
        [weakself endRefreshing];
        !failure?:failure(request);
    }];
    [self start];


}

- (id)requestArgument{
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:self.param];
    // 添加分页功能
    if (self.pageSize>0) {
        [temp setValue:@(self.pager) forKey:@"pageNo"];
        [temp setValue:@(self.pageSize) forKey:@"pageSize"];
    }
    return temp;
}


@end


@implementation YXBaseUploadApi

// 新的上传多张图片
- (instancetype)initWithImagesArray:(NSArray<UIImage *> *)imagesArray{
    if (self = [super init]) {
        
        self.url = @"/files/upload/permanent";
        self.constructingBodyBlock = ^(id<AFMultipartFormData>  _Nonnull formData) {
          for (UIImage *image in imagesArray) {
              @autoreleasepool {
                  NSData *data = UIImageJPEGRepresentation(image, 1);
                  //                    NSData *data = [weak_self compressImageQuality:image toByte:1000*1024];
                                         
                  NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[[NSString stringWithUUID]md5String]];
                                           
                  [formData appendPartWithFileData:data name:@"files[]" fileName:fileName mimeType:@"image/jpeg"];
                                  
              }
          }
        };
    }
    return self;
}

// 上传图片
- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super init]) {
       
        self.url = @"file/upload";
        self.image = image;
        self.param = [NSMutableDictionary dictionaryWithCapacity:10];
        NSData *data = UIImageJPEGRepresentation(image, 1);
        self.constructingBodyBlock = ^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"" fileName:@"" mimeType:@"image/jpeg"];
        };
    }
    return self;
}
- (void)upload:(ResponseSucsBlock)success failure:(ResponseFailBlock)fail{
    [self showProgress];
    @weakify(self)
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self_weak_ hideProgress];
        !success?:success(request.responseObject[@"fileUpload"][@"id"]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !fail?:fail(@"网络请求失败");
    }];
}


+ (void)upload:(NSArray<UIImage *> *)imagesArray sucess:(ResponseSucsBlock)success failure:(ResponseFailBlock)fail {
    [[[YXBaseUploadApi alloc]initWithImagesArray:imagesArray] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",request.responseString);
        !success?:success(request.responseObject[@"files"]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

@end
