//
//  ZFBaseSettingViewController.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "YXSettingController.h"
#import <objc/runtime.h>
#import "YXTableViewCell.h"
#import "YXTextFieldCell.h"

@interface YXSettingController (){
    UISwitch *_s;
}
@property (copy, nonatomic) void(^switchChangeBlock)(BOOL on);

@property (strong, nonatomic) UITableViewCell *maskcell;

@end

@implementation YXSettingController


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.sectionFooterHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
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

    if (item.type == GSettingItemTypeSignout) {
        YXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signout"];
        if (!cell) {
            cell = [[YXTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signout"];
        }
        cell.item = item;
        return cell;
    } else if (item.type == GSettingItemTypeValue1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"value1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"value1"];
        }
        cell.textLabel.text = item.title;
        cell.detailTextLabel.text = item.subtitle;
        if (item.subTitleColor)cell.detailTextLabel.textColor = item.subTitleColor;
        if (item.titleColor)cell.textLabel.textColor = item.titleColor;
        if (item.titleFont)cell.textLabel.font = item.titleFont;
        if (item.subtitleFont)cell.textLabel.font = item.subtitleFont;
        return cell;
    }else if (item.type == GSettingItemTypeTextField){
        YXTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textField"];
        if (!cell) {
            cell = [[YXTextFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textField"];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"default"];
            if (item.showDisclosureIndicator) {
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:item.accessoryNormalIcon]];
            }
        }
        cell.textLabel.text = item.title;
        cell.detailTextLabel.text = item.subtitle;
        if (item.subTitleColor)cell.detailTextLabel.textColor = item.subTitleColor;
        if (item.titleColor)cell.textLabel.textColor = item.titleColor;
        if (item.titleFont)cell.textLabel.font = item.titleFont;
        if (item.subtitleFont)cell.textLabel.font = item.subtitleFont;
        if (item.icon)cell.imageView.image = [UIImage imageNamed:item.icon];
        if (item.showDisclosureIndicator){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row == item.selectedRow && item.showDisclosureIndicator) {
            [cell.accessoryView setValue:[UIImage imageNamed:item.accessorySelectedIcon] forKey:@"image"];
            self.maskcell = cell;
        }
        return cell;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    YXSettingGroup *group = _allGroups[indexPath.section];
    YXSettingItem *item = group.items[indexPath.row];
    if (item.accessorySelectedIcon) {
        if (![cell isEqual:self.maskcell] && item.showDisclosureIndicator) {
            [cell.accessoryView setValue:[UIImage imageNamed:item.accessorySelectedIcon] forKey:@"image"];
            [self.maskcell.accessoryView setValue:[UIImage imageNamed:item.accessoryNormalIcon] forKey:@"image"];
            self.maskcell = cell;
        }
    }
    // 1.取出这行对应模型中的block代码
    if (item.cellBlock) {
        // 执行block
        item.cellBlock(item);
    }
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


#pragma mark - setter
- (void)setMaskcell:(UITableViewCell *)maskcell{
    _maskcell = maskcell;
    self.selectedIndexPath = [self.tableView indexPathForCell:maskcell];
}
@end
