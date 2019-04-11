//
//  YXAppDelegate.h
//  AFNetworking
//
//  Created by 顾玉玺 on 2019/4/10.
//

@import Foundation;
@import UIKit;
NS_ASSUME_NONNULL_BEGIN


@interface YXAppDelegateManager : NSObject

+ (void)registerDelegate:(Class)className;
+ (void)registerDelegates:(NSArray<NSString *> *)classNameArr;
@end

NS_ASSUME_NONNULL_END
