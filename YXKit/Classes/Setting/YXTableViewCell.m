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
#import <ReactiveObjC.h>
#import <YXPrefixConfig.h>
@import Foundation;
@implementation YXTableViewCell

- (void)updateConstraints{
    [super updateConstraints];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.line];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat space = KSpace;
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.offset(space);
            make.bottom.offset(0);
            make.right.inset(space);
        }];
        
        
        if ([reuseIdentifier isEqualToString:@"subtitle"]) {
            
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(space);
                make.right.inset(space);
                make.top.offset(12);
            }];
            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
                make.right.inset(space);
                make.bottom.inset(space);
            }];
        }else if([reuseIdentifier isEqualToString:@"Value3"]){
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(space);
                make.top.equalTo(self.subtitleLabel.mas_top);
            }];
            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right).offset(8);
                make.top.offset(15);
                make.right.inset(space);
                make.bottom.inset(15).priorityLow();
//                make.height.mas_greaterThanOrEqualTo(44);
            }];
            [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            
        }else if([reuseIdentifier isEqualToString:@"Value3_center"]){
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(space);
                make.top.equalTo(self.subtitleLabel.mas_top);
            }];
            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right).offset(8);
                make.top.offset(8);
                make.right.inset(space);
                make.bottom.inset(8).priorityLow();
//                make.height.mas_greaterThanOrEqualTo(44);
            }];
            [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            
        }else if([reuseIdentifier isEqualToString:@"Value4"]){
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(15);
                make.left.offset(space);
                make.bottom.inset(15).priorityMedium();
            }];
            
            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.inset(space);
                make.top.equalTo(self.titleLabel);
                make.left.equalTo(self.titleLabel.mas_right).offset(8);
            }];
        
        }else if ([reuseIdentifier isEqualToString:@"fullImage"]){
            [self.contentView addSubview:self.imageV];
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.inset(space);
            }];
        }else{
            self.textLabel.textColor = [UIColor colorWithHexString:@"#555555"];
            self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#888888"];
            self.textLabel.font = [UIFont systemFontOfSize:14];
            self.detailTextLabel.font = [UIFont systemFontOfSize:14];
            self.textLabel.numberOfLines = 0;
        }
    
    }
    return self;
}





- (void)configWithData:(YXSettingItem *)data{
    
    self.accessoryType = data.accessoryType;
    self.accessoryView = data.accessoryview;
    self.line.hidden = data.hideSeparatorLine;
    self.selected = data.selected;
    
    if (data.type == GSettingItemTypeDefault) {
        self.textLabel.attributedText = data.title;
        self.imageView.image = [UIImage imageNamed:data.icon];
    }else if (data.type == GSettingItemTypeSubtitle){
        self.titleLabel.attributedText = data.title;
        self.subtitleLabel.attributedText = data.subtitle;
    }else if (data.type == GSettingItemTypeValue1){
        self.textLabel.attributedText = data.title;
        self.detailTextLabel.attributedText = data.subtitle;
    }else if (data.type == GSettingItemTypeValue3||data.type == GSettingItemTypeValue4||data.type == GSettingItemTypeValue3_fit){
        self.titleLabel.attributedText = data.title;
        self.subtitleLabel.attributedText = data.subtitle;
    }else if (data.type == GSettingItemTypeFullImage){
        if (data.image) {
            self.imageV.image = data.image;
        }
        if (data.url.length) {
            [self.imageV setImageURL:[NSURL URLWithString:data.url]];
        }
    }
    @weakify(self)
    if (data.isObserveSubtitle) {
        [[RACObserve(data, subtitle) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            if (data.type == GSettingItemTypeValue3||data.type == GSettingItemTypeValue3_fit||data.type == GSettingItemTypeValue4 || data.type == GSettingItemTypeSubtitle) {
                self_weak_.subtitleLabel.attributedText = x;
            }else{
                self_weak_.detailTextLabel.attributedText = x;
            }
        }];
    }
    
    if (data.isObserveTitle) {
        [[RACObserve(data, title) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            NSLog(@"sub   订阅了几次呀");
            if (data.type == GSettingItemTypeValue3||data.type == GSettingItemTypeValue3_fit||data.type == GSettingItemTypeValue4 || data.type == GSettingItemTypeSubtitle) {
                self_weak_.titleLabel.attributedText = x;
            }else{
                self_weak_.textLabel.attributedText = x;
            }
        }];
    }
  
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
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
    }
    return _imageV;
}

@end
