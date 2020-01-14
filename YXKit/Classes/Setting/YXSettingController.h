//
//  ZFBaseSettingViewController.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSettingGroup.h"
#import "YXSettingItem.h"


@interface YXSettingController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allGroups;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic) BOOL canDelete;

@end
