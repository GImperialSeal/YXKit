//
//  YXRACViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/12.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXRACViewController.h"
#import <ReactiveObjC.h>
#import "YXDownLoad.h"
@interface YXRACViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation YXRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
//TODO: cotact 语法
    
//    RACSignal *single1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"1"];
//        [subscriber sendCompleted];
//        return [RACDisposable  disposableWithBlock:^{
//            NSLog(@"gone");
//        }];
//    }];
//
//    RACSignal *single2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"2"];
////        [subscriber sendCompleted];
//        return [RACDisposable  disposableWithBlock:^{
//            NSLog(@"gone2");
//        }];
//    }];
//
//    [[single1 concat:single2] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x: %@",x);
//    }];
    
    

    // TODO: then 语法
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"single"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"gone");
//        }];
//    }] then:^RACSignal * _Nonnull{
//        NSLog(@"then");
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"single 2"];
//            return [RACDisposable disposableWithBlock:^{
//                NSLog(@"gone 2");
//            }];
//        }];
//    }]  subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x: %@",x);
//    }];
    
    
//    YXDownLoad *model  = [YXDownLoad new];
    
//    RACChannelTo(self.tf, text) = RACChannelTo(model, name);
    
//    RACChannelTo(self.tf, text) = RACChannelTo(model, name);
//    RACChannelTo(self.tf, text) = RACChannelTo(model, name);
//    RACChannelTo(self.tf, text) = RACChannelTo(model, name);
    
//    RAC(self.tf, text) = RACObserve(model, name);
    
    [[self.tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length<9;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x: %@", x);
    }];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        model.name = @"测试一下下";
//    });
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.tf.text = @"你妈的";
//
//        NSLog(@"%@",model.name);
//    });
 
}






- (void)dealloc{
    
}

- (void)aaaaaaaa:(NSString *)format, ...{
    va_list args;
    
    va_start(args, format);
    NSString *otherString;
    while ((otherString = va_arg(args, NSString *))) {
        NSLog(@"format: %@",otherString);
    }
    
    va_end(args);
}

@end
