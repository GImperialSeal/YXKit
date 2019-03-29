//
//  YXTestLeak.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/14.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "YXTestLeak.h"
#import <objc/message.h>
#import <YYKit.h>
#import "YXAppDelegate.h"
@implementation YXTestLeak

void eat(){
    NSLog(@"aaaaaa");
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//
//
//    if ([NSStringFromSelector(sel) isEqualToString:@"eat"]) {
//
//        class_addMethod([self class], @selector(eat), (IMP)eat, "v:@");
//    }
//
//
//    return [super resolveClassMethod:sel];
//}

-(NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    if (selector == @selector(eat)) {
        return [NSMethodSignature signatureWithObjCTypes:"v:@"];
    }
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    if (anInvocation.selector == @selector(eat)) {
        
        [anInvocation invokeWithTarget:[YXAppDelegate new]];
    }
}
@end
