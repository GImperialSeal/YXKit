//
//  GTextFieldCell.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "YXTextFieldCell.h"
#import "UITextField+Limit.h"
@implementation YXTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setItem:(YXSettingItem *)item{
    _item = item;
    self.textField.placeholder = item.placeholder;
    self.textField.keyboardType = item.keyType;
    self.textField.limitLength = item.limitEditLength;
    self.textField.editedBlock = item.editBlock;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
