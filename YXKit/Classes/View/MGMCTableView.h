//
//  MGMCTableView.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/16.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCDevice;
typedef void(^SelectedFinishedBlock)(id obj);

@interface MGMCTableView : UIView<UITableViewDelegate,UITableViewDataSource>
// tableview
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, strong) SelectedFinishedBlock finishedBlock;

@property (nonatomic) BOOL translucent;

@property (nonatomic) UIBarStyle style;

@property (nonatomic, strong) id  selectedModel;


/**
 default 10
 */
@property (nonatomic) CGFloat tableFooterH;
/**
 default 44
 */
@property (nonatomic) CGFloat rowH;

/**
 frame 只需设定高度
 */
@property (nonatomic, strong) UIView *headerView;

/**
 frame 只需要设定高度
 */
@property (nonatomic, strong) UIView *footerView;




- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;


@end
