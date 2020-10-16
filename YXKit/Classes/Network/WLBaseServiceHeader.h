//
//  WLBaseServiceHeader.h
//  wlive
//
//  Created by Fane on 2020/7/10.
//  Copyright © 2020 wcsz. All rights reserved.
//

#ifndef WLBaseServiceHeader_h
#define WLBaseServiceHeader_h

@protocol WLRefreshProtocol <NSObject>

@required

// 表/tableview 或者 collectionView
@property (nonatomic, strong, readonly)UIScrollView *scrollView;

// 数据的数组
@property (nonatomic, strong)NSMutableArray *datas;

// 请求数据
- (void)networkForListDatas;

@end

#endif /* WLBaseServiceHeader_h */
