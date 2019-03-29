//
//  YXTableViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/21.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "YXTableViewController.h"
#import "ProgramTestCell.h"
#import "RunloopManager.h"
@interface YXTableViewController ()
@property (nonatomic, strong)RunloopManager *manager;

@end

@implementation YXTableViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[RunloopManager alloc]init];
}

- (void)dealloc{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UIImageView *)createImageView:(CGFloat)x{
    NSString *path = [NSBundle.mainBundle pathForResource:@"angle" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    UIImage *img = [UIImage imageWithData:data];
    UIImageView *imgL = [[UIImageView alloc]initWithImage:img];
    imgL.frame = CGRectMake(x, 0, 80, 80);
    return imgL;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    __weak typeof(self)weakself = self;
    [self.manager addRunloopTask:^{
        [cell.contentView addSubview:[weakself createImageView:0]];
    }];
    
//    [self addTask:^{
////        [weakcell.contentView addSubview:[weakself createImageView:80]];
//    }];
//
//    [self addTask:^{
////        [weakcell.contentView addSubview:[weakself createImageView:160]];
//    }];

    return cell;
}



@end
