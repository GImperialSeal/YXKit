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


@protocol YXAlertProtocol <NSObject>

@property (nonatomic, strong)NSString *alertTitle;

@end

typedef void(^YXAlertBlock)(id obj);


@interface YXSettingController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_allGroups; // 所有的组模型
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allGroups;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


- (void)alertSheet:(NSString *)title mssage:(NSString *)msg sheet:(NSArray<YXAlertProtocol> *)titles completion:(YXAlertBlock)block;

- (void)alertStringSheet:(NSString *)title mssage:(NSString *)msg sheet:(NSArray<NSString *> *)titles completion:(YXAlertBlock)block;

@end
