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
#import "ReactiveObjC.h"
//#import "UITableView+FDTemplateLayoutCell.h"
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
    YXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.reuseIdentifier];
    if (!cell) {
        if (item.style == YXTableViewCellStyleTextField) {
            cell = [[YXTextFieldCell alloc]initWithItem:item];
        }else{
            cell = [[YXTableViewCell alloc]initWithItem:item];
        }
    }
    [cell configWithData:item];
    return cell;
}


// 浅灰色
- (NSAttributedString *)defaultSubtitle:(NSString *)text font:(CGFloat)font{
    if (!text.length) { return nil; }
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:[UIColor redColor]}];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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


- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.canDelete) {
        //删除
        __weak typeof(self)weakself = self;
        UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            YXSettingGroup *group = _allGroups[indexPath.section];
            YXSettingItem *item = group.items[indexPath.row];
            !item.deleteBlock?:item.deleteBlock();
            [group.items removeObjectAtIndex:indexPath.row];
            [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            completionHandler (YES);

        }];
        //    deleteRowAction.title = @"删除";
        //    deleteRowAction.backgroundColor = [UIColor redColor];
        
        return [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    }else{
        return [UISwipeActionsConfiguration configurationWithActions:@[]];
    }
   
}




@end
