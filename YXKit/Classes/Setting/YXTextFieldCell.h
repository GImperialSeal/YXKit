//
//  GTextFieldCell.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSettingItem.h"
@interface YXTextFieldCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) YXSettingItem *item;

@end