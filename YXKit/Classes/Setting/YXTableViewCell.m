//
//  YXTableViewCell.m
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import "YXTableViewCell.h"
#import <Masonry.h>
@import Foundation;


@implementation YXTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.line];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.offset(15);
            make.bottom.offset(0);
            make.right.inset(15);
        }];
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

//-(void)addSubview:(UIView *)view{
//    NSString* className = NSStringFromClass([view class]);
//    if (![className isEqualToString:@"UIButton"]&&
//        ![className isEqualToString:@"UITableViewCellContentView"]){
//        return;
//    }
//    [super addSubview:view];
//}

@end
