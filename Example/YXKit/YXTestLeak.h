//
//  YXTestLeak.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/14.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXTestLeak : NSObject
@property (nonatomic, strong)dispatch_block_t block;

@end

NS_ASSUME_NONNULL_END
