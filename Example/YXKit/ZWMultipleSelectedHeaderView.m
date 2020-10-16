//
//  ZWMultipleSelected.m
//  zw_app
//
//  Created by 顾玉玺 on 2019/8/1.
//  Copyright © 2019 中维科技. All rights reserved.
//

#import "ZWMultipleSelectedHeaderView.h"
#import <Masonry.h>
#import <YXMacro.h>
#import <YXKit.h>
@implementation ZWMultipleSelectedHeaderView


- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel.text = title;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, self.bounds.size.height-0.5, self.bounds.size.width-30, 0.5)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self addSubview:line];
        [self addSubview:self.done];
        [self addSubview:self.cancel];
        [self addSubview:self.titleLabel];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(0.5);
        }];

        [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KSpace);
            make.centerY.offset(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(24);
        }];
        [self.done mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.inset(KSpace);
            make.centerY.offset(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(24);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cancel.mas_right).offset(8);
            make.right.equalTo(self.done.mas_left).inset(8);
//            make.right.equalTo(self.done.mas_left).inset(8).priorityLow();
//            make.centerX.offset(0);
            make.top.bottom.offset(0);
            make.height.mas_equalTo(49);
        }];
    }
    return self;
}

- (void)evnetForDone:(UIButton *)sender{
    !self.doneBlock?:self.doneBlock();
}

- (void)evnetForCancel:(UIButton *)sender{
    !self.cancelBlock?:self.cancelBlock();
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    return _titleLabel;
}


- (UIButton *)done{
    if (!_done) {
        _done = [UIButton buttonWithType:UIButtonTypeCustom];
        [_done addTarget:self action:@selector(evnetForDone:) forControlEvents:UIControlEventTouchUpInside];
        [_done setTitleColor:[UIColor colorWithHexString:@"#20B1F4"] forState:UIControlStateNormal];
        [_done setTitle:@"完成" forState:UIControlStateNormal];
        [_done.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _done.layer.borderWidth = 1;
        _done.layer.borderColor = [UIColor colorWithHexString:@"#20B1F4"].CGColor;
        _done.layer.cornerRadius = 3;
    }
    return _done;
}

- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel addTarget:self action:@selector(evnetForCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_cancel setTitleColor:[UIColor colorWithHexString:@"#20B1F4"] forState:UIControlStateNormal];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _cancel.layer.borderWidth = 1;
        _cancel.layer.borderColor = [UIColor colorWithHexString:@"#20B1F4"].CGColor;
        _cancel.layer.cornerRadius = 3;
    }
    return _cancel;
}

@end
