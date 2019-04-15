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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setItem:(YXSettingItem *)item{
    _item = item;
    if (item.keyType) self.textField.keyboardType = item.keyType;
    if (item.placeholder) self.textField.placeholder = item.placeholder;
    if (item.limitEditLength) self.textField.limitLength = item.limitEditLength;
    if (item.placeholder) self.textField.placeholder = item.placeholder;
    if (item.editBlock) self.textField.editedBlock = item.editBlock;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectInset(self.bounds, 15, 0)];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [_textField setValue:@10 forKey:@"paddingLeft"];
    }
    return _textField;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
