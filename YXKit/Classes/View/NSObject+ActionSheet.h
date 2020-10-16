//
//  NSObject+ActionSheet.h
//  zw_app
//
//  Created by 顾玉玺 on 2019/5/10.
//  Copyright © 2019年 中维科技. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ZWMultipleSelectedBaseView.h"

NS_ASSUME_NONNULL_BEGIN


@interface NSObject (ActionSheet)

//- (void)showSheetViewWithTitles:(NSArray *)titlesArray completion:(void(^)(NSInteger index))complete;
//
//
///**
// 单选
//
// @param title 标题
// @param datasArray 数据, 字符串或者模型
// @param selectedArray 默认选中的数据 字符串或者模型
// @param cancelBlock 取消
// @param selectedBlock 完成
// */
//- (void)multipleSelected:(NSString *)title
//              datasArray:(NSArray *)datasArray
//           selectedArray:(nullable NSArray *)selectedArray
//                  cancel:(dispatch_block_t)cancelBlock
//           selectedBlock:(YXNoticeSelectedFinishedBlock)selectedBlock;
//
//- (void)singleSelected:(NSString *)title
//            datasArray:(NSArray *)datasArray
//          selectedData:(nullable id<ZWMultipleSelectedProtocol>)selectedData
//         selectedBlock:(YXNoticeSelectedFinishedBlock)selectedBlock;
//
//-(NSString *)get_yxtitle:(NSArray<id<ZWMultipleSelectedProtocol>> *)arr;//获取名字拼接
//-(NSString *)get_yxID:(NSArray<id<ZWMultipleSelectedProtocol>> *)arr;//获取ID拼接
//-(NSString *)get_yxCode:(NSArray<id<ZWMultipleSelectedProtocol>> *)arr;//获取code拼接

@end

NS_ASSUME_NONNULL_END
