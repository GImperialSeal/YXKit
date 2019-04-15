//
//  YXTableViewCell.h
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSettingItem.h"
@interface YXTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *signoutLabel;
@property (nonatomic, strong) YXSettingItem *item;

@end
