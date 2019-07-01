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
@import Foundation;
@implementation YXTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.line];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat space = UIScreen.mainScreen.bounds.size.width>375.f?20.f:15.f;

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
                make.top.offset(12);
            }];
            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right).offset(12);
                make.top.equalTo(self.titleLabel);
                make.right.inset(space);
                make.bottom.inset(12);
            }];
            [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            
        }else if([reuseIdentifier isEqualToString:@"Value4"]){
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(space);
                make.top.offset(12);
                make.bottom.inset(12);
            }];
            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right).offset(12);
                make.top.equalTo(self.titleLabel);
                make.right.inset(space);
            }];
            [self.subtitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        }else if ([reuseIdentifier isEqualToString:@"fullImage"]){
            [self.contentView addSubview:self.fullImageView];
            [self.fullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.inset(space);
            }];
        }
        
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
        _titleLabel.numberOfLines = 0;

    }
    return _titleLabel;
}

- (UIImageView *)fullImageView{
    if (!_fullImageView) {
        _fullImageView = [[UIImageView alloc]init];
    }
    return _fullImageView;
}


- (void)configWithData:(YXSettingItem *)data{
    
    self.accessoryType = data.accessoryType;
    self.accessoryView = data.accessoryview;
    self.line.hidden = data.hideSeparatorLine;
    
    
    if (data.type == GSettingItemTypeDefault) {
        self.textLabel.attributedText = data.title;
        self.imageView.image = [UIImage imageNamed:data.icon];
    }else if (data.type == GSettingItemTypeSubtitle){
        self.titleLabel.attributedText = data.title;
        self.subtitleLabel.attributedText = data.subtitle;
    }else if (data.type == GSettingItemTypeValue1){
        self.textLabel.attributedText = data.title;
        self.detailTextLabel.attributedText = data.subtitle;
    }else if (data.type == GSettingItemTypeValue3||data.type == GSettingItemTypeValue4){
        self.titleLabel.attributedText = data.title;
        self.subtitleLabel.attributedText = data.subtitle;
    }else if (data.type == GSettingItemTypeFullImage){
        if (data.image) {
            self.fullImageView.image = data.image;
        }
        if (data.url.length) {
            [self.fullImageView setImageURL:[NSURL URLWithString:data.url]];
        }
    }
    @weakify(self)
    if (data.isObserveSubtitle) {
        [[RACObserve(data, subtitle) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            NSLog(@"sub   订阅了几次呀");
            if (data.type == GSettingItemTypeValue3||data.type == GSettingItemTypeValue4 || data.type == GSettingItemTypeSubtitle) {
                self_weak_.subtitleLabel.attributedText = x;
            }else{
                self_weak_.detailTextLabel.attributedText = x;
            }
        }];
    }
    
    if (data.isObserveTitle) {
        [[RACObserve(data, title) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            NSLog(@"sub   订阅了几次呀");
            if (data.type == GSettingItemTypeValue3||data.type == GSettingItemTypeValue4 || data.type == GSettingItemTypeSubtitle) {
                self_weak_.titleLabel.attributedText = x;
            }else{
                self_weak_.textLabel.attributedText = x;
            }
        }];
    }
  
}

@end
