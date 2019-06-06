//
//  YXTableViewCell.m
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import "YXTableViewCell.h"
#import <Masonry.h>
#import <YYKit.h>
@import Foundation;


@implementation YXTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.line];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.offset(15);
            make.bottom.offset(0);
            make.right.inset(15);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(12);
            make.top.offset(12);
        }];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
            make.top.equalTo(self.titleLabel);
            make.right.inset(12);
            make.bottom.inset(12);
        }];
       
        self.textLabel.textColor = [UIColor colorWithHexString:@"#555555"];
        self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#888888"];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(15, self.bounds.size.height-0.5, self.bounds.size.width-30, 0.5)];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.font = [UIFont systemFontOfSize:14];
        _subtitleLabel.textColor = [UIColor colorWithHexString:@"#888888"];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    return _titleLabel;
}


- (void)configWithData:(YXSettingItem *)data{
    self.accessoryType = data.accessoryType;
    self.accessoryView = data.accessoryview;
    self.line.hidden = data.hideSeparatorLine;
//    self.textLabel.text = data.titleText;
//    self.detailTextLabel.text = data.subtitleText;
//    if (data.title) {
        self.textLabel.attributedText = data.title;
//    }
//    if (data.subtitle) {
        self.detailTextLabel.attributedText = data.subtitle;
    
   

//    }
}


@end
