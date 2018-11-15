//
//  WKWebViewHelper.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/15.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "WKWebViewHelper.h"
@import WebKit;
@implementation WKWebViewHelper
+ (void)clearCookies{
    
    if (@available(iOS 9.0, *)) {
        //清除cookie和localStorage
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[NSSet setWithObjects:WKWebsiteDataTypeCookies,WKWebsiteDataTypeLocalStorage, nil]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record  in records)
                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                        }];
                             }
                         }];
        
    }
  
}
@end
