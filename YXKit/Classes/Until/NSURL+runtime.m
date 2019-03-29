//
//  NSURL+runtime.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/23.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "NSURL+runtime.h"
#import <objc/runtime.h>
#import "NSObject+runtime.h"
@implementation NSURL (runtime)


+ (void)load{

//    Method new = class_getClassMethod(self, @selector(yx_URLWithString:));
//    Method old = class_getClassMethod(self, @selector(URLWithString:));
//    method_exchangeImplementations(new, old);
    
    
}


+ (instancetype)yx_URLWithString:(NSString *)URLString{
    NSLog(@"方法交换啦");
    NSString *url = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return [NSURL yx_URLWithString:url];
}
@end
