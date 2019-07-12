//
//  YXResources.h
//  YXKit
//
//  Created by 顾玉玺 on 2019/7/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXResources : NSObject

+ (UIImage *)imageNamed:(NSString *)name;

+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString*)bundleName;


@end

NS_ASSUME_NONNULL_END
