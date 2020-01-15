//
//  YXTableViewCell.m
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import "YXTableViewCell.h"
#import "Masonry.h"
#import "YYKit.h"
#import "ReactiveObjC.h"
#import <YXPrefixConfig.h>
#import "YXMacro.h"
@import Foundation;
@implementation YXTableViewCell

- (void)updateConstraints{
    [super updateConstraints];
}

- (instancetype)initWithItem:(YXSettingItem *)item{
    UITableViewCellStyle style = 0;
    if (item.style>3) {
        style = 0;
    }
    if (self = [super initWithStyle:style reuseIdentifier:item.reuseIdentifier]) {
        [self addSubview:self.line];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat space = KSpace;
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.offset(space);
            make.bottom.offset(0);
            make.right.inset(space);
        }];
        
        
        if (item.style == YXTableViewCellStyleSubtitle) {

            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            self.titleLabel.numberOfLines = 1;

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
        }else if(item.style == YXTableViewCellStyleValue3){
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            self.titleLabel.numberOfLines = 1;
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(space);
                make.top.equalTo(self.subtitleLabel.mas_top);
            }];

            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right).offset(8);
                make.top.offset(KSpace);
                make.right.inset(space);
                make.bottom.inset(KSpace);
            }];
            [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        }else if(item.style == YXTableViewCellStyleValue4){
            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.subtitleLabel];
            self.subtitleLabel.numberOfLines = 1;

            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(KSpace);
                make.left.offset(space);
                make.bottom.inset(KSpace);
            }];

            [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.inset(space);
                make.top.equalTo(self.titleLabel);
                make.left.equalTo(self.titleLabel.mas_right).offset(8);
            }];
            [self.subtitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        }else{
            self.textLabel.textColor = [UIColor colorWithHexString:@"#555555"];
            self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#888888"];
            self.textLabel.font = [UIFont systemFontOfSize:14];
            self.detailTextLabel.font = [UIFont systemFontOfSize:14];
            self.textLabel.numberOfLines = 0;
        }
    
                   
           if (item.style == YXTableViewCellStyleValue3||
               item.style == YXTableViewCellStyleValue3_fit||
               item.style == YXTableViewCellStyleValue4 ||
               item.style == YXTableViewCellStyleSubtitle) {
               if (item.isObserveTitle) {
                   RAC(self.titleLabel, attributedText) = [RACObserve(item, title) takeUntil:self.rac_prepareForReuseSignal];
               }
               if (item.isObserveSubtitle) {
                   RAC(self.subtitleLabel, attributedText) = [RACObserve(item, subtitle) takeUntil:self.rac_prepareForReuseSignal];
               }
           }else{
               if (item.isObserveTitle) {
                   RAC(self.textLabel, attributedText) = [RACObserve(item, title) takeUntil:self.rac_prepareForReuseSignal];
               }
               if (item.isObserveSubtitle) {
                   RAC(self.detailTextLabel, attributedText) = [RACObserve(item, subtitle) takeUntil:self.rac_prepareForReuseSignal];
               }

           }
    }
    return self;
}



- (void)configWithData:(YXSettingItem *)item{
    
    self.accessoryType = item.accessoryType;
    self.accessoryView = item.accessoryview;
    self.line.hidden = item.hideSeparatorLine;
    
    
    if (item.style == YXTableViewCellStyleDefault) {
        self.textLabel.attributedText = item.title;
        self.imageView.image = [UIImage imageNamed:item.icon];
    }else if (item.style == YXTableViewCellStyleSubtitle){
        self.titleLabel.attributedText = item.title;
        self.subtitleLabel.attributedText = item.subtitle;
        self.imageView.image = [UIImage imageNamed:item.icon];
    }else if (item.style == YXTableViewCellStyleValue1){
        self.textLabel.attributedText = item.title;
        self.detailTextLabel.attributedText = item.subtitle;
    }else if (item.style == YXTableViewCellStyleValue3||item.style == YXTableViewCellStyleValue4||item.style == YXTableViewCellStyleValue3_fit){
        self.titleLabel.attributedText = item.title;
        self.subtitleLabel.attributedText = item.subtitle;
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
        _subtitleLabel = [YXLabel new];
        _subtitleLabel.font = [UIFont systemFontOfSize:14];
        _subtitleLabel.textColor = [UIColor colorWithHexString:@"#888888"];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)spareLabel{
    if (!_spareLabel) {
        _spareLabel = [YXLabel new];
        _spareLabel.font = [UIFont systemFontOfSize:14];
        _spareLabel.textColor = [UIColor colorWithHexString:@"#888888"];
        _spareLabel.numberOfLines = 0;
    }
    return _spareLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [YXLabel new];
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




@implementation YXLabel

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.pasteBoard = [UIPasteboard generalPasteboard];
    
    [self attachTapHandle];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.pasteBoard = [UIPasteboard generalPasteboard];
        
        [self attachTapHandle];
    }
    return self;
}



- (void)attachTapHandle {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
}

//响应事件
- (void)handleTap:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder]; //UILabel默认是不能响应事件的，所以要让它成为第一响应者
        UIMenuController *menuVC = [UIMenuController sharedMenuController];
        [menuVC setTargetRect:self.frame inView:self.superview]; //定位Menu
        [menuVC setMenuVisible:YES animated:YES]; //展示Menu
        
    }
}




-(BOOL)canPerformAction:(SEL)action withSender:(id)sender { //指定该UICopyLabel可以响应的方法
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}

-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    if (self.attributedText) {
        pboard.string = self.attributedText.string;
    }else{
        pboard.string = self.text;
    }
    
    NSLog(@"text: %@",pboard.string);
}

@end
