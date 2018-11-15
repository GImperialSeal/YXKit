//
//  ClearCacheHelper.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/15.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "ImageCacheHelper.h"
#import "WKWebViewHelper.h"
#import "YYKit.h"

@implementation ImageCacheHelper

+ (void)yy_clearImageCache:(void(^)(int removedCount, int totalCount))progress completion:(void(^)(BOOL err))finish{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjectsWithProgressBlock:progress endBlock:finish];
}

+ (void)wk_clearCookies{
    [WKWebViewHelper clearCookies];
}

+ (NSString *)yy_imageCacheSize{
    YYImageCache *imageCache = [YYWebImageManager sharedManager].cache;
    NSInteger size = imageCache.memoryCache.totalCost + imageCache.diskCache.totalCost;
    
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1K
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1M
        CGFloat kFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fKB",kFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat mFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fMB",mFloat];
    }else{
        CGFloat gFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fGB",gFloat];
    }
}

@end
