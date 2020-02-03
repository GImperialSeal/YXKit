//
//  YXStorageModel.h
//  YXKit
//
//  Created by 顾玉玺 on 2020/1/19.
//

#import <Foundation/Foundation.h>
#import "LLStorageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YXStorageModel : LLStorageModel
// 3个主键
- (NSString *)storageIdentity;
- (NSString *)storageSecondIdentity;
- (NSString *)storageThreeIdentity;

@end

NS_ASSUME_NONNULL_END
