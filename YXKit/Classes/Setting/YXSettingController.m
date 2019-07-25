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
#import <UITableView+FDTemplateLayoutCell.h>
@interface YXSettingController ()

@end

@implementation YXSettingController


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100;
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
    
    [self.tableView registerClass:YXTableViewCell.class forCellReuseIdentifier:@"Value3"];
    [self.tableView registerClass:YXTableViewCell.class forCellReuseIdentifier:@"Value3_center"];
    [self.tableView registerClass:YXTableViewCell.class forCellReuseIdentifier:@"Value4"];
    [self.tableView registerClass:YXTableViewCell.class forCellReuseIdentifier:@"subtitle"];
    [self.tableView registerClass:YXTableViewCell.class forCellReuseIdentifier:@"fullImage"];
//    [self.tableView registerClass:YXTableViewCell.class forCellReuseIdentifier:@"Default"];
}

- (NSString *)reuserIndentifier:(GSettingItemType)type{
    switch (type) {
        case GSettingItemTypeTextField:
            return @"TextField";
        case GSettingItemTypeValue1:
            return @"Value1";
        case GSettingItemTypeValue3:
            return @"Value3";
        case GSettingItemTypeValue3_fit:
            return @"Value3_center";
        case GSettingItemTypeValue4:
            return @"Value4";
        case GSettingItemTypeSubtitle:
            return @"subtitle";
        case GSettingItemTypeFullImage:
            return @"fullImage";
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
        case GSettingItemTypeSubtitle:
            return UITableViewCellStyleSubtitle;
        case GSettingItemTypeFullImage:
            return UITableViewCellStyleDefault;
        case GSettingItemTypeValue4:
            return UITableViewCellStyleDefault;
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
    return group.limitRow == -1? group.items.count:group.limitRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXSettingGroup *group = _allGroups[indexPath.section];
    YXSettingItem *item = group.items[indexPath.row];
    NSString *identifier = [self reuserIndentifier:item.type];

    if (item.type == GSettingItemTypeTextField) {
        YXTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YXTextFieldCell alloc]initWithStyle:[self cellStyle:item.type] reuseIdentifier:identifier];
        }
        [cell configWithData:item];
        return cell;
    }else  if (item.type == GSettingItemTypeValue1||item.type == GSettingItemTypeDefault) {
        YXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YXTableViewCell alloc]initWithStyle:[self cellStyle:item.type] reuseIdentifier:identifier];
        }
        [cell configWithData:item];
        return cell;

    }else{
        YXTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [cell configWithData:item];
        return cell;
    }
}


// 浅灰色
- (NSAttributedString *)defaultSubtitle:(NSString *)text font:(CGFloat)font{
    if (!text.length) { return nil; }
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:[UIColor redColor]}];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell.selected) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
//    cell.selected = !cell.selected;
    YXSettingGroup *group = _allGroups[indexPath.section];
    YXSettingItem *item = group.items[indexPath.row];
    
    item.selected = !item.selected;
    
    cell.selected = item.selected;
    
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
    
    if (item.type == GSettingItemTypeValue3||
        item.type == GSettingItemTypeValue4||
        item.type == GSettingItemTypeValue3_fit||
        item.type == GSettingItemTypeSubtitle||
        item.type == GSettingItemTypeFullImage) {
        return [tableView fd_heightForCellWithIdentifier:[self reuserIndentifier:item.type] cacheByIndexPath:indexPath configuration:^(YXTextFieldCell *cell) {
            [cell configWithData:item];
        }];
    }else{
        return item.rowHeight;
    }
   
}



@end
