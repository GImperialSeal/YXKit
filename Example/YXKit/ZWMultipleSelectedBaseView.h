//
//  YXNoticeTableView.h
//  YXKit
//
//  Created by 顾玉玺 on 2019/7/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    single,// 单选
    multiple,//多选
} YXNoticeSelectedType;

@protocol ZWMultipleSelectedProtocol <NSObject>

/**
 标题
 */
@property (nonatomic, strong, readonly)NSString *yx_title;

@optional

@property (nonatomic, strong, readonly)NSString *yx_id;
@property (nonatomic, strong, readonly)NSString *yx_code;

@end

// 选中的数据, index 选中的索引  是否选中已选的
typedef void(^YXNoticeSelectedFinishedBlock)(NSArray *selectedArray,NSInteger index,BOOL repeat,id<ZWMultipleSelectedProtocol> lastSelectedObj);


@interface ZWMultipleSelectedBaseView : UIView

/**
 单选或者多选, 默认单选
 */
@property (nonatomic)YXNoticeSelectedType yx_select_type;


/**
 i:  headerview  和 footerview 要可以根据内容自适应高度
 */
@property (nonatomic, strong)UIView *headerView;

@property (nonatomic, strong)UIView *footerView;

@property (nonatomic, strong)YXNoticeSelectedFinishedBlock block;

@property (nonatomic, strong)NSMutableArray<id<ZWMultipleSelectedProtocol>> *selectedArray;

@property (nonatomic, strong)NSArray<id<ZWMultipleSelectedProtocol>> *datasArray;


/**
 最多显示几行, 默认6行, 超过6行可以滑动
 */
@property (nonatomic)NSInteger maxDisplayCount;

+ (instancetype)multipleSelectedView:(NSArray *)datasArray selectedArray:(NSArray *)selectedArray;

- (void)reloadData;

@end

@interface YXNoticeCell : UITableViewCell

@end


@interface ZWMultipleSelectedModel : NSObject<ZWMultipleSelectedProtocol>

@property (nonatomic, strong)NSString *yx_title;

@property (nonatomic, strong)NSString *yx_id;

@end


NS_ASSUME_NONNULL_END
