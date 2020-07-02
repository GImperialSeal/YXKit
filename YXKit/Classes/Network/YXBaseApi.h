//
//  AIBaseViewModel.h
//  AIStock
//
//  Created by 顾玉玺 on 2019/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
@class YXBaseRefreshApi;
NS_ASSUME_NONNULL_BEGIN


// 使用此类,或者继承此类完成请求
typedef void(^ResponseFailBlock)(NSString * msg);

typedef void(^ResponseSucsBlock)(id model);

@protocol YXRefreshProtocol <NSObject>

// 表
@property (nonatomic, strong, readonly)UITableView *tableView;

// 数据的数组
@property (nonatomic, strong)NSMutableArray *datas;

// 请求数据
- (void)networkForListDatas;


@end



@interface YXBaseApi : YTKRequest

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *header;
@property (nonatomic, strong) NSURLRequest * customRequest;
@property (nonatomic) NSInteger cacheTime;//
@property (nonatomic) BOOL useCache;
@property (nonatomic) YTKRequestMethod method;
@property (nonatomic) YTKRequestSerializerType  requestType;
@property (nonatomic) YTKResponseSerializerType responseType;
@property (nonatomic, strong)id body;
@property (nonatomic,assign) BOOL isAutoLogin;
// default true
@property (nonatomic) BOOL showToast;
// default true
@property (nonatomic) BOOL showProgressView;


@property (nonatomic, weak) UIView *addedView;

- (void)printLog:(YTKBaseRequest *)request;

- (void)showTextHUD:(id)msg;
- (void)showProgress;
- (void)hideProgress;

- (void)handleRequest:(YTKBaseRequest *)request success:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure;

@end

#pragma - 分页的请求
@interface YXBaseRefreshApi : YXBaseApi
// 带分页请求的类, 使用此初始化方法
- (instancetype)initRefreshDelegate:(id<YXRefreshProtocol>)delegate;

/**
 默认为10
 */
@property (nonatomic)NSInteger pageSize;

@property (nonatomic)NSInteger pager;// 默认1

@property (nonatomic)NSInteger total;// 数据总数

@property (nonatomic)BOOL unRefresh;// 是否需要刷新
@property (nonatomic)BOOL unLoadMore;// 是否需要刷新

@property (nonatomic,weak)id <YXRefreshProtocol> refreshDelegate;//

- (void)beginRefreshing;
- (void)beginRefreshing:(BOOL)animated;

- (void)endRefreshing;

@end

@interface YXBaseUploadApi : YXBaseApi
// 单个图片上传
- (instancetype)initWithImage:(UIImage *)image;

// 上传的图片
@property (nonatomic,strong)UIImage *image;// 默认1

// 单个图片上传的回调, 返回文件的id
- (void)upload:(ResponseSucsBlock)success failure:(ResponseFailBlock)fail;

// 上图一组图片
+ (void)upload:(NSArray<UIImage *> *)imagesArray sucess:(ResponseSucsBlock)success failure:(ResponseFailBlock)fail;


@end

NS_ASSUME_NONNULL_END
