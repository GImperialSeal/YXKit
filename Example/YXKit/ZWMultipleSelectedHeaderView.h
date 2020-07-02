//
//  ZWMultipleSelected.h
//  zw_app
//
//  Created by 顾玉玺 on 2019/8/1.
//  Copyright © 2019 中维科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWMultipleSelectedHeaderView : UIView

@property (nonatomic, strong)UIButton *done;

@property (nonatomic, strong)UIButton *cancel;

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)dispatch_block_t cancelBlock;

@property (nonatomic, strong)dispatch_block_t doneBlock;

- (instancetype)initWithTitle:(NSString *)title;
@end
//
//@interface ZWMultipleSelectedFooterView : UIView
//
////@property (nonatomic, strong)UIButton *done;
////
////@property (nonatomic, strong)UIButton *cancel;
//
//@property (nonatomic, strong)UIButton *btn;
//
//@property (nonatomic, strong)dispatch_block_t cancelBlock;
//
//@property (nonatomic, strong)dispatch_block_t doneBlock;
//
//- (instancetype)initWithTitle:(NSString *)title;
//@end

NS_ASSUME_NONNULL_END
