//
//  YXTableViewCell.h
//  PowerM3
//
//  Created by 顾玉玺 on 2017/4/11.
//  Copyright © 2017年 qymgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSettingItem.h"


@interface YXTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView *line;

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *subtitleLabel;

@property (nonatomic, strong)UILabel *spareLabel;// 备用的lab, 懒加载, 默认是没有添加到视图上

@property (nonatomic, strong)UIImageView *imageV;

- (void)configWithData:(YXSettingItem *)data;

- (void)setImageView:(UIImageView *)IV url:(NSString *)url;
@end
