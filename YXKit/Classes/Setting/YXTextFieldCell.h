//
//  GTextFieldCell.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSettingItem.h"
#import "YXTableViewCell.h"
@interface YXTextFieldCell : YXTableViewCell

@property (nonatomic, strong)UITextField *tf;
//@property (nonatomic, strong)UILabel *titleLabel;
- (void)configWithData:(YXSettingItem *)data;

- (void)limit:(YXSettingItem *)item;

@end
