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

@property (nonatomic, weak)NSString *weakString;

@end

@implementation YXRACViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"will string: %@", self.weakString);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"did string: %@", self.weakString);
}

- (void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"self: %@",self);
    }];
  
    // 场景1
//    NSString *str = [NSString stringWithFormat:@"1212312"];
//    self.weakString = str;
//    NSLog(@"场景1 string: %@", self.weakString);

    // 场景2
//    @autoreleasepool {
//        NSString *str = [NSString stringWithFormat:@"1212312"];
//        self.weakString = str;
//    }
//    NSLog(@"场景2 string: %@", self.weakString);

//    NSLog(@"执行开始");
//
//    for (int i = 0; i<50000000; i++) {
//        id obj = [[NSObject alloc] init];
//    }
//    NSLog(@"执行结束");
    // 场景 3
//        NSString *string = nil;
//        @autoreleasepool {
//            string = [NSString stringWithFormat:@"1234567890"];
//            self.weakString = string;
//        }
//        NSLog(@"string: %@",self.weakString);

    
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
    
//    [[self.tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        return value.length<9;
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"x: %@", x);
//    }];
    
  

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
