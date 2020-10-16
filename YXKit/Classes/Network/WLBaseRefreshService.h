//
//  WLBaseRefreshService.h
//  wlive
//
//  Created by Fane on 2020/7/7.
//  Copyright © 2020 wcsz. All rights reserved.
//

#import "WLBaseService.h"
#import "WLEmptyView.h"
#import "WLBaseServiceHeader.h"
NS_ASSUME_NONNULL_BEGIN



#pragma - 分页的请求
@interface WLBaseRefreshService : WLBaseService

// 带分页请求的类, 使用此初始化方法
- (instancetype)initRefreshDelegate:(id<WLRefreshProtocol>)delegate;

@property (nonatomic)NSInteger pageSize;// 默认10

@property (nonatomic)NSInteger pager;// 默认1

@property (nonatomic)NSInteger pagerType;//0为id 1 为updateTime 2 为pager

@property (nonatomic) Class serializerClass;// 请求成功, 默认使用此类去解析数据, 成功返回list

@property (nonatomic, strong) WLEmptyView *emptyView;

@property (nonatomic,weak)id <WLRefreshProtocol> refreshDelegate;


- (void)beginRefreshing;// 刷新不带动画
- (void)beginRefreshing:(BOOL)animated;// 刷新带动画
- (void)endRefreshing;// 结束刷新
- (void)removeMJHeader;// 移除刷新
- (void)removeJMFooter;// 移除下拉加载

@end


/// private 内部使用
@interface WLBaseRefreshService (serializer)

- (NSInteger)total;

- (NSArray *)list;// 返回的list 尚未解析

- (NSDictionary *)pagerParamHandle;

- (void)loadMoreHandle;// 处理分页

@end


NS_ASSUME_NONNULL_END
