//
//  ClearCacheHelper.h
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/15.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ImageCacheHelper : NSObject

// 清理yy图片缓存
+ (void)yy_clearImageCache:(void(^)(int removedCount, int totalCount))progress completion:(void(^)(BOOL err))finish;

// 计算yy图片缓存
+ (NSString *)yy_imageCacheSize;

// 清理网页缓存
+ (void)wk_clearCookies;


@end
