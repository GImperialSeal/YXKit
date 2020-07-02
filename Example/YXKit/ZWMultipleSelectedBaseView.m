//
//  YXNoticeTableView.m
//  YXKit
//
//  Created by 顾玉玺 on 2019/7/31.
//

#import "ZWMultipleSelectedBaseView.h"
#import <Masonry.h>
#import <YYKit.h>
@interface ZWMultipleSelectedBaseView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tv;

@end

@interface YXNoticeCell()

@property (strong, nonatomic) UIImageView *mark;
@property (strong, nonatomic) UILabel *titleLabel;

@end


@implementation ZWMultipleSelectedBaseView

+ (instancetype)multipleSelectedView:(NSArray *)datasArray selectedArray:(NSArray *)selectedArray{
    
    NSMutableArray *source = [NSMutableArray arrayWithCapacity:datasArray.count];
    NSMutableArray *source_selected = [NSMutableArray arrayWithCapacity:selectedArray.count];

    BOOL isString = NO;
    for (id obj in datasArray) {
        if ([obj isKindOfClass:NSString.class]) {
            isString = YES;
            ZWMultipleSelectedModel *model = [ZWMultipleSelectedModel new];
            model.yx_title = obj;
            [source addObject:model];
            
            if ([selectedArray containsObject:obj]) {
                [source_selected addObject:model];
            }
        }else{
            break;
        }
    }
    
    ZWMultipleSelectedBaseView *tv = [[self alloc]initWithFrame:CGRectNull];
    if (isString) {
        tv.datasArray = source;
        [tv.selectedArray addObjectsFromArray:source_selected];
    }else{
        tv.datasArray = datasArray;
        [tv.selectedArray addObjectsFromArray:selectedArray?:@[]];
    }
   
    [tv reloadData];
    return tv;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.yx_select_type = single;
        self.maxDisplayCount = 6;
        [self addSubview:self.tv];
    }
    return self;
}

- (void)reloadData{
    [self.tv reloadData];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[YXNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        
    }
    cell.titleLabel.text = self.datasArray[indexPath.row].yx_title;
    id obj = self.datasArray[indexPath.row];

    if ([self.selectedArray containsObject:obj]) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.yx_select_type == single && self.selectedArray.count>0) {
        [self.selectedArray removeAllObjects];
    }
    id obj = self.datasArray[indexPath.row];
    [self.selectedArray addObject:obj];

//    if (self.yx_select_type == single) {
        !self.block?:self.block(self.selectedArray,indexPath.row,[self.selectedArray containsObject:obj],obj);
//    }

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    id obj = self.datasArray[indexPath.row];
    [self.selectedArray removeObject:obj];
}

#pragma mark - get set

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (NSMutableArray *)selectedArray{
   
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectedArray;
}

- (UITableView *)tv{
    if (!_tv) {
        _tv = [[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStyleGrouped];
        _tv.delegate = self;
        _tv.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        _tv.dataSource = self;
        _tv.rowHeight = 44;
        _tv.sectionFooterHeight = 0;
        _tv.sectionHeaderHeight = 0.5;
//        _tv.allowsMultipleSelection = YES;
    }
    return _tv;
}

- (void)setYx_select_type:(YXNoticeSelectedType)yx_select_type{
    _yx_select_type = yx_select_type;
    _tv.allowsMultipleSelection = yx_select_type;

}


- (void)setFooterView:(UIView *)footerView{
    _footerView = footerView;
    _tv.sectionFooterHeight = 10;

    [self addSubview:footerView];
    [self setNeedsUpdateConstraints];

}

- (void)setHeaderView:(UIView *)headerView{
    _headerView = headerView;
    [self addSubview:headerView];
    [self setNeedsUpdateConstraints];
}


- (void)setDatasArray:(NSArray<id<ZWMultipleSelectedProtocol>> *)datasArray{
    _datasArray = datasArray;
    self.tv.scrollEnabled = datasArray.count>self.maxDisplayCount;
    [self setNeedsUpdateConstraints];
}


#pragma mark -布局
- (void)updateConstraints{
    
    if (_footerView) {
        [_footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.top.equalTo(self.tv.mas_bottom);
        }];
    }
    
    if (_headerView) {
        [_headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
        }];
    }
    
    [_tv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        
        if (self.headerView) {
            make.top.equalTo(self.headerView.mas_bottom);
        }else{
            make.top.offset(0);
        }
        
        if (self.footerView) {
            
        }else{
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.equalTo(self);
            }
        }
        CGFloat h =  self.datasArray.count>self.maxDisplayCount?44*self.maxDisplayCount:44*self.datasArray.count;
        make.height.mas_equalTo(h + (self.footerView?10.5:0.5));
    }];
    
  
    [super updateConstraints];
}

@end


#pragma mark - cell

@implementation YXNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.mark];
        [self.contentView addSubview:self.titleLabel];
        [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.inset(12);
            make.centerY.equalTo(self.titleLabel).offset(0);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mark.mas_right).offset(8);
            make.right.inset(15);
            make.top.offset(15);
            make.bottom.inset(15).priorityLow();
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.mark.highlighted = selected;
    
}


- (UIImageView *)mark{
    if (!_mark) {
        _mark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选中-灰色"] highlightedImage:[UIImage imageNamed:@"选中-蓝色"]];
    }
    return _mark;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    return _titleLabel;
} 

@end


@implementation ZWMultipleSelectedModel



@end
