//
//  GTextFieldCell.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "YXTextFieldCell.h"
#import <Masonry.h>
#import <ReactiveObjC.h>
#import <YYKit.h>
#import <YXPrefixConfig.h>
@implementation YXTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tf];
        [self.contentView addSubview:self.titleLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat space = KSpace;
        
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.height.mas_equalTo(44);
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.right.inset(space);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(space);
            make.centerY.offset(0);
        }];
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
    }
    return self;
}

- (void)configWithData:(YXSettingItem *)data{
    self.tf.placeholder = data.placeholder;
    self.tf.keyboardType = data.keyType;
    self.tf.text = data.text;
    self.accessoryView = data.accessoryview;
    self.titleLabel.attributedText = data.title;
    @weakify(self)
    

    [[[self.tf.rac_textSignal takeUntil:self.rac_prepareForReuseSignal] map:^id _Nullable(NSString * _Nullable value) {
        return value.length>data.limitEditLength?[value substringToIndex:data.limitEditLength]:value;
    }] subscribeNext:^(NSString *x) {
        
        if (data.accessoryview &&[data.accessoryview isKindOfClass:UILabel.class]&&data.isObserveSubtitle) {
            NSString *strLength = [NSString stringWithFormat:@"%lu",(unsigned long)x.length];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%d",strLength,data.limitEditLength]];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#20B1F4"] range:NSMakeRange(0, strLength.length)];
            [data.accessoryview setValue:str forKey:@"attributedText"];
        }
        data.text = x;
        !data.editBlock?:data.editBlock(x);
    }];
}

- (UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc]init];
        _tf.borderStyle = UITextBorderStyleNone;
        //        _tf.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tf.font = [UIFont systemFontOfSize:15];
        //        _tf.textColor = [UIColor colorWithHexString:@"#26B3F4"];
        //        _tf.layer.cornerRadius = 1;
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
        //        label.text = @" －";
        //        [label sizeToFit];
        //        _tf.leftView = label;
        //        _tf.leftViewMode = UITextFieldViewModeAlways;
    }
    return _tf;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
