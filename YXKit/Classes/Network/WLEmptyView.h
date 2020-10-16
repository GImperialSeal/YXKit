//
//  WLEmptyView.h
//  wlive
//
//  Created by Fane on 2020/7/7.
//  Copyright © 2020 wcsz. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface WLEmptyView : UIView

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *descLabel;

@property(nonatomic, strong) UIButton *retryButton;

+ (instancetype)emptyWithIndicatorView;

+ (instancetype)emptyWithRetry:(dispatch_block_t)retryBlock;

+ (instancetype)emptyWithError:(NSError *)error;

+ (instancetype)emptyView;
@end

NS_ASSUME_NONNULL_END
