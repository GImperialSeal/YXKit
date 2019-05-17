//
//  YXTableViewCell.h
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSettingItem.h"
@protocol YXBaseTableViewCellProtocol <NSObject>

@property (nonatomic, strong)UIButton *accessoryBtnView;

@end

@interface YXTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIView *zwView;

@property (nonatomic)id<YXBaseTableViewCellProtocol> delegate;

@end
