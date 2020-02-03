//
//  YXStorageManager.h
//  YXKit
//
//  Created by 顾玉玺 on 2020/1/17.
//

#import <Foundation/Foundation.h>
#import "LLStorageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXStorageManager : NSObject

+ (instancetype)manager;

- (BOOL)registerClass:(Class)cls;

- (void)transactionForInsert:(NSArray *)datas;

- (void)transactionForUpdate:(NSArray *)datas;

- (void)transactionForDelete:(NSArray *)datas;

- (NSArray *)query:(Class)cls storageId:(NSString *)storageIdentity;
- (NSArray *)query:(Class)cls storageSecondId:(NSString *)storageIdentity;
- (NSArray *)query:(Class)cls storageThirdId:(NSString *)storageIdentity;
@end

NS_ASSUME_NONNULL_END
