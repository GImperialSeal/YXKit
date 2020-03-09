//
//  YXGIFViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/22.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXGIFViewController.h"
#import <YYKit.h>
#import <YWTableExcelView.h>
@interface YXGIFViewController ()<YWTableExcelViewDelegate,YWTableExcelViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *gif;

@property (nonatomic, strong) NSMutableArray *fixedColumnList;
@property (nonatomic, strong) NSMutableArray *slideColumnList;
@property (nonatomic, strong) NSMutableArray  *fixedList;
@property (nonatomic, strong) NSMutableArray  *slideList;
@end

@implementation YXGIFViewController

- (void)dealloc
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.gif removeFromSuperview];

    [self addData:@""];

     YWTableExcelViewMode *mode = [[YWTableExcelViewMode alloc]init];
               mode.columnStyle = YWTableExcelViewColumnStyleText;
            mode.defalutHeight = 30;
            mode.columnBorderWidth = 1;
    mode.columnBorderColor = [UIColor clearColor];
    YWTableExcelView *_excel = [[YWTableExcelView alloc]initWithFrame:CGRectMake(20, 100, 375, 400) withMode:mode];
            _excel.tag  = 100;
               _excel.delegate = self;
               _excel.dataSource = self;
               _excel.addverticalDivider = YES;
               _excel.addHorizontalDivider = YES;
               _excel.dividerColor = [UIColor clearColor];
               _excel.layer.borderWidth = 0;
               _excel.selectionStyle = YWTableExcelViewCellSelectionStyleGray;
    
//    _excel.backgroundColor = [UIColor orangeColor];
    
    
    // 方案一  无边框
               
                     //默认选中第一行
    //                 [_excel selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
               [self.view addSubview:_excel];
//    [_excel reloadData];
    
    
//    NSString *path = [[NSBundle bundleWithURL:[NSURL fileURLWithPath:@"YXBindle.bundle"]]pathForResource:@"快来添加设备" ofType:@"gif"];
//    self.gif.imageURL = [NSURL fileURLWithPath:path];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addData:(NSString *)data{
//    NSArray *array = [data modelToJSONObject];
    
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//
//    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:10];
//    for (NSString *str  in array) {
//        NSArray *a = [[
//                       [str stringByReplacingOccurrencesOfString:@"     " withString:@"#"]
//                       stringByReplacingOccurrencesOfString:@"   " withString:@"#"] componentsSeparatedByString:@"#"];
//        NSMutableArray *columnArray = [NSMutableArray array];
//        for (NSString *column in a) {
//            YWColumnMode *mode = [[YWColumnMode alloc]init];
//            mode.width = 80;
//            mode.textColor = [UIColor blackColor];
//            mode.text = column;
//            [columnArray addObject:mode];
//        }
//
//        [rows addObject:columnArray];
//    }
//
//    self.datas = rows;
//
    CGFloat w = UIApplication.sharedApplication.keyWindow.width;
     NSArray *arr1 = @[@"语文",@"数学",@"物理",@"化学"];
      _slideColumnList = [NSMutableArray new];
      for (NSString *ts in arr1) {
          YWColumnMode *model1 = [YWColumnMode new];
          model1.text = @"";
          model1.width = (NSInteger)(w/arr1.count)-10;
          [self.slideColumnList addObject:model1];
      }

      _slideList = @[].mutableCopy;
      for (int j = 0; j < 7; j ++) {
          NSMutableArray *cloumnList = @[].mutableCopy;
          for (int i = 0; i < arr1.count; i ++) {
              YWColumnMode *model1 = [YWColumnMode new];
              model1.text = [NSString stringWithFormat:@"%d行%d列",j,i];
              [cloumnList addObject:model1];
          }
          [_slideList addObject:cloumnList];
      }
    
    
       
      
}

// 固定列
- (NSArray<YWColumnMode *> *)tableExcelView:(YWTableExcelView *)excelView titleForFixedHeaderInSection:(NSInteger)section{
    return @[];
}
- (NSArray<YWColumnMode *> *)tableExcelView:(YWTableExcelView *)excelView fixedCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


-(NSArray<YWColumnMode *> *)tableExcelView:(YWTableExcelView *)excelView titleForSlideHeaderInSection:(NSInteger)section{
    return _slideColumnList;
}
- (NSInteger)tableExcelView:(YWTableExcelView *)excelView numberOfRowsInSection:(NSInteger)section{
    return [_slideList count];
}

- (NSArray<YWColumnMode *> *)tableExcelView:(YWTableExcelView *)excelView slideCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _slideList[indexPath.row];
}

@end
