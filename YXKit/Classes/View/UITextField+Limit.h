//
//  UITextField+Limit.h
//  MiGuQRCode
//
//  Created by 顾玉玺 on 2018/4/10.
//  Copyright © 2018年 顾玉玺. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditedBlock)(NSString *text);

typedef void(^EdittingBlock)(NSString *text);

@interface UITextField (Limit)

@property (nonatomic) NSInteger limitLength;

@property (nonatomic, copy) EditedBlock editedBlock;

@property (nonatomic, copy) EdittingBlock edittingBlock;

@end
