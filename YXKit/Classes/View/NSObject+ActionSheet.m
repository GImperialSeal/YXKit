//
//  NSObject+ActionSheet.m
//  zw_app
//
//  Created by 顾玉玺 on 2019/5/10.
//  Copyright © 2019年 中维科技. All rights reserved.
//

#import "NSObject+ActionSheet.h"
//#import <ZGQActionSheetView.h>
//#import "ZWMultipleSelectedHeaderView.h"
//#import "ZWVisitPatrolView.h"
//#import <YXPrefixConfig.h>
//#import <MGMCActionView.h>
//#import <ReactiveObjC.h>
//#import <Masonry.h>
@implementation NSObject (ActionSheet)

//- (void)showSheetViewWithTitles:(NSArray *)titlesArray completion:(void(^)(NSInteger index))complete{
//    ZGQActionSheetView *sheetView = [[ZGQActionSheetView alloc] initWithOptions:titlesArray completion:complete cancel:^{}];
//    [sheetView show];
//}
//
//
//
//
//- (void)multipleSelected:(NSString *)title
//              datasArray:(NSArray *)datasArray
//           selectedArray:(NSArray *)selectedArray
//                  cancel:(dispatch_block_t)cancelBlock
//           selectedBlock:(YXNoticeSelectedFinishedBlock)selectedBlock{
//    if (datasArray.count==0) {return; }
//    
//    ZWMultipleSelectedBaseView *view = [ZWMultipleSelectedBaseView multipleSelectedView:datasArray selectedArray:selectedArray];
//    view.yx_select_type = multiple;
//    
//    ZWMultipleSelectedHeaderView *headerView = [[ZWMultipleSelectedHeaderView alloc] initWithTitle:title];
//    headerView.cancelBlock = ^{
//        !cancelBlock?:cancelBlock();
//        [MGMCActionView dismissActionView:NO delay:0 completion:nil];
//    };
//    headerView.doneBlock = ^{
//        !selectedBlock?:selectedBlock(view.selectedArray,0,NO,view.selectedArray.lastObject);
//        [MGMCActionView dismissActionView:NO delay:0 completion:nil];
//    };
//    view.headerView = headerView;
//    
//    
//    CGFloat h = [YXPrefixConfig systemLayoutSizeFittingSizeWithWidth:KW contentView:view];
//    view.frame = CGRectMake(0, KH-h, KW, h);
//    [MGMCActionView showActionView:view dirction:ActionSheetDirectionBottom animated:YES];
//    //    return view;
//}
//
//- (void)aaaaa{
//}
//
//- (void)singleSelected:(NSString *)title
//              datasArray:(NSArray *)datasArray
//           selectedData:(id<ZWMultipleSelectedProtocol>)selectedData
//           selectedBlock:(YXNoticeSelectedFinishedBlock)selectedBlock{
//    if (datasArray.count==0) {return; }
//    
//    ZWMultipleSelectedBaseView *view = [ZWMultipleSelectedBaseView multipleSelectedView:datasArray selectedArray:selectedData?@[selectedData]:nil];
//    view.block = ^(NSArray * _Nonnull selectedArray, NSInteger index, BOOL repeat,id obj) {
//        !selectedBlock?:selectedBlock(selectedArray,index,repeat,selectedArray.lastObject);
//        [MGMCActionView dismissActionView:NO delay:0 completion:nil];
//    };
//    
//    view.yx_select_type = single;
//    
//    if (title.length) {
//        ZWMultipleSelectedHeaderView *headerView = [[ZWMultipleSelectedHeaderView alloc] initWithTitle:title];
//        headerView.cancel.hidden = YES;
//        headerView.done.hidden = YES;
//        view.headerView = headerView;
//    }
//    
//    view.footerView = [self defaultFooterView];
//    
//    
//    
//    CGFloat h = [YXPrefixConfig systemLayoutSizeFittingSizeWithWidth:KW contentView:view];
//    view.frame = CGRectMake(0, KH-h, KW, h);
//    [MGMCActionView showActionView:view dirction:ActionSheetDirectionBottom animated:YES];
//}
//
//
//- (UIView *)defaultFooterView{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"取消" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor whiteColor];
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [MGMCActionView dismissActionView:NO delay:0 completion:nil];
//    }];
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    UIView *footerView = [UIView new];
//    [footerView addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//        make.height.mas_equalTo(56);
//    }];
//    
//    return footerView;
//}
//
//-(NSString *)get_yxtitle:(NSArray<id<ZWMultipleSelectedProtocol>> *)arr{
//    NSMutableArray *aray = [NSMutableArray arrayWithCapacity:arr.count];
//    for (id<ZWMultipleSelectedProtocol> obj in arr) {
//        [aray addObject:obj.yx_title];
//    }
//    return [aray componentsJoinedByString:@","];
//}
//-(NSString *)get_yxID:(NSArray<id<ZWMultipleSelectedProtocol>> *)arr{
//    NSMutableArray *aray = [NSMutableArray arrayWithCapacity:arr.count];
//    for (id<ZWMultipleSelectedProtocol> obj in arr) {
//        [aray addObject:obj.yx_id];
//    }
//    return [aray componentsJoinedByString:@","];
//}
//-(NSString *)get_yxCode:(NSArray<id<ZWMultipleSelectedProtocol>> *)arr{
//    NSMutableArray *aray = [NSMutableArray arrayWithCapacity:arr.count];
//    for (id<ZWMultipleSelectedProtocol> obj in arr) {
//        [aray addObject:obj.yx_code];
//    }
//    return [aray componentsJoinedByString:@","];
//}


@end
