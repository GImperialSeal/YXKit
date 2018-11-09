//
//  MGMCTableView.m
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/16.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import "MGMCTableView.h"
#import "MGMCActionView.h"
@interface MGMCTableView()

@property (nonatomic, strong) UIToolbar *backView;

@property (nonatomic, strong) UITableViewCell *maskCell;

@property (nonatomic) NSInteger selectedRow;

@end

@implementation MGMCTableView

- (void)defaultValue{
    self.rowH = 44;
    self.translucent = YES;
    self.style = UIBarStyleDefault;
    self.tableFooterH = 10;
}
- (instancetype)init{
    if (self = [super init]) {
        [self defaultValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self defaultValue];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        self.titlesArray = titles;
        [self defaultValue];
    }
    return self;
}


#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedModel = self.titlesArray[indexPath.row];
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [MGMCActionView dismissActionView:YES delay:0.25 completion:^{
        if (self.finishedBlock) {
            self.finishedBlock(self.titlesArray[indexPath.row]);
        }
    }];
}


- (void)layoutSubviews{
    NSLog( @"测试:    layoutSubviews");

    CGSize headersize = CGSizeZero;
    CGSize footersize = CGSizeZero;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    if (self.translucent) {
        UIToolbar *backView = [[UIToolbar alloc] initWithFrame:self.bounds];
        backView.barStyle   = self.style;
        [self addSubview:backView];
    }

    if (self.headerView) {
        [self addSubview:self.headerView];
        headersize = self.headerView.frame.size;
        self.headerView.frame = CGRectMake(0, 0, w, headersize.height);

    }
    if (self.footerView) {
        [self addSubview:self.footerView];
        footersize = self.footerView.frame.size;
    }
    
    [self addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, headersize.height, w, h - headersize.height - footersize.height);
    if (self.footerView) {
        self.footerView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), w, footersize.height);
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = self.rowH;
        tableView.sectionFooterHeight = self.tableFooterH;
        tableView.sectionHeaderHeight = 0.5;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        _tableView = tableView;
    }
    return _tableView;
}

@end
