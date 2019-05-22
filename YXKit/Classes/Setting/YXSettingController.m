//
//  ZFBaseSettingViewController.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "YXSettingController.h"
#import "YXTableViewCell.h"
#import "YXTextFieldCell.h"
#import <ReactiveObjC.h>

@interface YXSettingController (){
    UISwitch *_s;
}
@property (copy, nonatomic) void(^switchChangeBlock)(BOOL on);

@end

@implementation YXSettingController





- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)allGroups{
    if (!_allGroups) {
        _allGroups = [NSMutableArray array];
    }
    return _allGroups;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (NSString *)reuserIndentifier:(GSettingItemType)type{
    switch (type) {
        case GSettingItemTypeTextField:
            return @"TextField";
        case GSettingItemTypeValue1:
            return @"Value1";
        case GSettingItemTypeValue3:
            return @"Value3";
        default:
            return @"Default";
    }
}
- (UITableViewCellStyle)cellStyle:(GSettingItemType)type{
    switch (type) {
        case GSettingItemTypeDefault:
            return UITableViewCellStyleDefault;
        case GSettingItemTypeValue1:
            return UITableViewCellStyleValue1;
        default:
            return UITableViewCellStyleDefault;
    }
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YXSettingGroup *group = _allGroups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXSettingGroup *group = _allGroups[indexPath.section];
    YXSettingItem *item = group.items[indexPath.row];
    NSString *identifier = [self reuserIndentifier:item.type];
    YXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YXTableViewCell alloc]initWithStyle:[self cellStyle:item.type] reuseIdentifier:identifier];
    }
    cell.textLabel.attributedText = item.title;
    cell.detailTextLabel.attributedText = item.subtitle;
    if (item.isObserveSubtitle) {
        [RACObserve(item, subtitle) subscribeNext:^(id  _Nullable x) {
            cell.detailTextLabel.attributedText = x;
        }];
    }
    if (item.isObserveTitle) {
        [RACObserve(item, title) subscribeNext:^(id  _Nullable x) {
            cell.textLabel.attributedText = x;
        }];
    }
    cell.imageView.image = [UIImage imageNamed:item.icon];
    cell.accessoryType = item.accessoryType;
    cell.accessoryView = item.accessoryview;
    cell.line.hidden = item.hideSeparatorLine;
    return cell;
   
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YXSettingGroup *group = _allGroups[indexPath.section];
    YXSettingItem *item = group.items[indexPath.row];
    // 1.取出这行对应模型中的block代码
    !item.cellBlock?:item.cellBlock(group,item,indexPath);
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YXSettingGroup *group = _allGroups[section];
    return group.header;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    YXSettingGroup *group = _allGroups[section];
    return group.footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    YXSettingGroup *group = _allGroups[section];
    return group.heightForFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    YXSettingGroup *group = _allGroups[section];
    return group.heightForHeader;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXSettingGroup *group = _allGroups[indexPath.section];
    YXSettingItem *item = group.items[indexPath.row];
    return item.rowHeight;
}



@end
