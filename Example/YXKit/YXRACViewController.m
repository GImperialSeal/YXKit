//
//  YXRACViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/12.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXRACViewController.h"
#import <ReactiveObjC.h>
@interface YXRACViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation YXRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self.tf.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"skip x: %@", x);

    }];
    [self.tf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"noskip x: %@", x);
    }];
    self.tf.text = @"测试1";
    [RACObserve(self.tf, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"kvo: x  %@",x);

    }];
    self.tf.text = @"测试2";
    @weakify(self);
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        NSLog(@"self: %@",self);
    }];
    
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 3.发送信号
        [subscriber sendNext:@""];
        return nil;
    }];

    // 2.订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    
    
    
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    
    
    RACSubject *subject;
    [subject bind:^RACSignalBindBlock _Nonnull{
        
    }];
}

- (void)dealloc{
    
}

@end
