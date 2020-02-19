//
//  GTextFieldCell.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "YXTextFieldCell.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "YYKit.h"
#import <YXPrefixConfig.h>
#import "YXMacro.h"
@implementation YXTextFieldCell

- (instancetype)initWithItem:(YXSettingItem *)item{
    if (self = [super initWithItem:item]) {
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
        
        self.tf.text = item.text;
        
        @weakify(self)
        [[self.tf.rac_textSignal  filter:^BOOL(NSString * _Nullable value) {
            NSLog(@"x: %@",value);
            // 最大值
            if (item.maximumValue>0) {
                if (value.integerValue>item.maximumValue) {
                    value = [NSString stringWithFormat:@"%ld",(long)item.maximumValue];
                    self_weak_.tf.text = value;
                }
            }

            // 提示
//            if (item.accessoryview &&[item.accessoryview isKindOfClass:UILabel.class]&&item.isObserveSubtitle) {
//                NSString *strLength = [NSString stringWithFormat:@"%lu",(unsigned long)value.length];
//                NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%d",strLength,item.limitEditLength]];
//                [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#20B1F4"] range:NSMakeRange(0, strLength.length)];
//                [item.accessoryview setValue:str forKey:@"attributedText"];
//            }

            //  字数限制
            [self_weak_ limit:item];
            return value.length<=item.limitEditLength;
        }] subscribeNext:^(NSString * _Nullable x) {
            !item.editBlock?:item.editBlock(x);
            item.text = x;
        }] ;
        
    }
    return self;
}

- (void)configWithData:(YXSettingItem *)data{
    self.tf.placeholder = data.placeholder;
    self.tf.keyboardType = data.keyType;
    self.titleLabel.attributedText = data.title;
    self.accessoryView = data.accessoryview;
}

- (void)limit:(YXSettingItem *)item{
    NSInteger kMaxLength = item.limitEditLength;
    
    NSString *toBeString = self.tf.text;
    
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [self.tf markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self.tf positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length >= kMaxLength) {
                self.tf.text = [toBeString substringToIndex:kMaxLength];
                if (item.editBlock) item.editBlock(self.tf.text);
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > kMaxLength) {
            self.tf.text = [toBeString substringToIndex:kMaxLength];
            if (item.editBlock) item.editBlock(self.tf.text);
        }
        
    }
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
