//
//  YXTableViewCell.m
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import "YXTableViewCell.h"
@import Foundation;
@implementation YXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.signoutLabel];
    }
    return self;
}

- (UILabel *)signoutLabel{
    if (!_signoutLabel) {
        
        _signoutLabel = [[UILabel alloc]initWithFrame:CGRectInset(self.bounds, 40, 0)];
        _signoutLabel.layer.cornerRadius = 4;
        _signoutLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _signoutLabel;
}

- (void)setItem:(YXSettingItem *)item{
    _item = item;
    if (item.signoutBGColor)self.signoutLabel.backgroundColor = item.signoutBGColor;
    self.signoutLabel.text = item.title;
}



-(void)addSubview:(UIView *)view{
    
    NSString* className = NSStringFromClass([view class]);
    
    if (![className isEqualToString:@"UIButton"]&&
        ![className isEqualToString:@"UITableViewCellContentView"]){
        return;
    }
    
    [super addSubview:view];
    
}

@end
