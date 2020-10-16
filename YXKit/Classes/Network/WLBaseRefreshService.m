//
//  WLBaseRefreshService.m
//  wlive
//
//  Created by Fane on 2020/7/7.
//  Copyright © 2020 wcsz. All rights reserved.
//

#import "WLBaseRefreshService.h"
#import <MJRefresh/MJRefresh.h>
#import <YYKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "BaseRefreshHeader.h"
@interface WLBaseRefreshService()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end



@implementation WLBaseRefreshService

- (void)defaultConfig{
    self.pager = 1;
    self.pageSize = 10;
    self.method = YTKRequestMethodPOST;
//    self.header = @{@"accept":@"application/json"}.mutableCopy;
}

- (instancetype)initRefreshDelegate:(id<WLRefreshProtocol>)delegate{
    self = [super init];
    if (self) {
        [self defaultConfig];
        self.refreshDelegate = delegate;
        __weak typeof(self)weakself = self;
        self.refreshDelegate.scrollView.mj_header = [BaseRefreshHeader headerWithRefreshingBlock:^{
            weakself.pager = 1;
            [weakself.refreshDelegate networkForListDatas];
        }];
        self.refreshDelegate.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.pager++;
            [weakself.refreshDelegate networkForListDatas];
        }];
        
        self.refreshDelegate.scrollView.emptyDataSetSource = self;
        self.refreshDelegate.scrollView.emptyDataSetDelegate = self;
        
        [(MJRefreshAutoNormalFooter *)self.refreshDelegate.scrollView.mj_footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        [(MJRefreshNormalHeader *)self.refreshDelegate.scrollView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
    }
    return self;
}
- (void)removeMJHeader{
    self.refreshDelegate.scrollView.mj_header  = nil;
}
- (void)removeJMFooter{
    self.refreshDelegate.scrollView.mj_footer  = nil;
}

- (BOOL)isRefreshing{
    return[self.refreshDelegate.scrollView.mj_header isRefreshing];
}

- (void)beginRefreshing{
    [self beginRefreshing:NO];
}

- (void)beginRefreshing:(BOOL)animated{
    self.pager = 1;
    if (animated) {
        [self.refreshDelegate.scrollView.mj_header beginRefreshing];
    }else{
        [self.refreshDelegate networkForListDatas];
    }
  
}

- (void)reloadData{
    if (_refreshDelegate) {
        [_refreshDelegate.scrollView performSelector:@selector(reloadData)];
    }

}
- (void)endRefreshing{
    if (_refreshDelegate) {
        [_refreshDelegate.scrollView.mj_header endRefreshing];
        [_refreshDelegate.scrollView.mj_footer endRefreshing];
    }
}


// 处理登录异常, 文本提示, 数据分页
- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    @weakify(self);
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request){
        @strongify(self);
        [self loadMoreHandle];
        if (self.refreshDelegate && self.serializerClass) {
            NSArray *list = [NSArray modelArrayWithClass:self.serializerClass json:self.list];
            [self.refreshDelegate.datas addObject:list];
            [self reloadData];
        }
        !success?:success(request);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request){
        @strongify(self);

        self.pager --;
        
        [self endRefreshing];
        [self.refreshDelegate.scrollView reloadEmptyDataSet];
        !failure?:failure(request);
    }];
}

- (id)requestArgument{
    //    return [EncryptionHelper encryptWithParams:[self pagerParamHandle]];
        return [self pagerParamHandle];
}




#pragma mark DZNEmptyDataSetSource
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -100;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    
    switch (self.status) {
        case WLRequestStatusError:
            return [WLEmptyView emptyWithIndicatorView];
        case WLRequestStatusNotReachable:{
            @weakify(self)
            return [WLEmptyView emptyWithRetry:^{
                [weak_self beginRefreshing:NO];
            }];
        }
        case WLRequestStatusEmptyData:
            return self.emptyView;
        default:
            return [WLEmptyView emptyWithIndicatorView];
    }
}

- (WLEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [WLEmptyView  emptyView];
    }
    return _emptyView;
}

#pragma mark DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if (self.isRefreshing) {
        return;
    }
    [self beginRefreshing:NO];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
//    if (self.hiddenEmptyView) {
//        return NO;
//    }
//    if (self.footerType) {
//        [self.contentView.mj_footer setHidden:self.datas.count <= 0];
//    }
    return YES;
}

- (void)retryBtnDidClicked:(UIButton *)sender{
//    [self beginRefreshing:YES];
}

@end




@implementation WLBaseRefreshService (serializer)

- (NSArray *)list{
    return self.result.list;
}


- (NSDictionary *)pagerParamHandle{
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:self.param];
    // 添加分页功能
    if (self.pager == 1) {
        if (self.pagerType == 1) {
            [temp setValue:@"" forKey:@"updateTime"];
        }else if (self.pagerType == 2) {
            [temp setValue:@(1) forKey:@"page"];
        }
        else{
            [temp setValue:@(0) forKey:@"id"];
        }
    }else{
        NSDictionary *dic = [self list].lastObject;
        if (self.pagerType == 1) {
            [temp setValue:dic[@"updateTime"] forKey:@"updateTime"];
        }else if (self.pagerType == 2) {
            [temp setValue:@(_pager) forKey:@"page"];
        }else{
            [temp setValue:dic[@"id"] forKey:@"id"];
        }
    }
    
    
    if (self.pagerType == 2) {
        [temp setValue:@(self.pageSize) forKey:@"pageSize"];
    }else{
        [temp setValue:@(self.pageSize) forKey:@"limit"];
    }

    
    return temp;
}

- (NSInteger)total{
    id obj = self.responseJSONObject[@"data"][@"totalRecords"];
    return [obj integerValue];
}

- (void)loadMoreHandle{
    if (!_refreshDelegate) {
           return;
       }
       if (self.pagerType == 2) {
                   
           if (self.pager == 1) {
               [_refreshDelegate.datas removeAllObjects];
               if (self.total == 0) {
                   self.status = WLRequestStatusEmptyData;
               }
           }
           [self.refreshDelegate.scrollView.mj_header endRefreshing];
           
           if ((self.pager*self.pageSize)>=self.total) {
               if (self.total>0) {
                   [_refreshDelegate.scrollView.mj_footer endRefreshingWithNoMoreData];
               }else{
                   [_refreshDelegate.scrollView.mj_footer endRefreshing];
               }
           }else{
               [_refreshDelegate.scrollView.mj_footer endRefreshing];
           }
           
       }else{
           if ([self list]) {
               NSArray *list = [self list];
               if (self.pager == 1) {
                   [_refreshDelegate.datas removeAllObjects];
                   if ([list count] == 0) {
                       self.status = WLRequestStatusEmptyData;
                   }
               }
               [self.refreshDelegate.scrollView.mj_header endRefreshing];
               
               // 没有更多内容了
               if (list.count<self.pageSize) {
                   [_refreshDelegate.scrollView.mj_footer endRefreshingWithNoMoreData];
               }else{
                   [_refreshDelegate.scrollView.mj_footer endRefreshing];
               }
           }else{
               self.status = WLRequestStatusEmptyData;
               [self.refreshDelegate.scrollView.mj_header endRefreshing];
               [_refreshDelegate.scrollView.mj_footer endRefreshing];
           }
       }
}

@end
