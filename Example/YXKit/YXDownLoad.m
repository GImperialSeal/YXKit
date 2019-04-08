//
//  YXDownLoad.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/3/30.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "YXDownLoad.h"

@implementation YXDownLoad

- (void)download{
    
    NSInteger currentLength = 0;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
    
    [request setValue:[NSString stringWithFormat:@"bytes=%zd-",currentLength] forHTTPHeaderField:@"Range"];
    
//    NSURLSessionDataTask *task = [NSURLSessionDataTask accessibilityAssistiveTechnologyFocusedIdentifiers
    
    
    
}

@end
