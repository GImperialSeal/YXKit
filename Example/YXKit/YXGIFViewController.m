//
//  YXGIFViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/22.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXGIFViewController.h"
#import <YYKit.h>
#import "YXTestLeak.h"
@interface YXGIFViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (nonatomic, strong)dispatch_block_t block1;
@property (nonatomic, strong)dispatch_block_t block2;
@property (nonatomic, strong)YXTestLeak *leak;
@property (nonatomic, strong)NSString *name;

@end

@implementation YXGIFViewController

- (void)dealloc
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    YXTestLeak *leak = [[YXTestLeak alloc]init];
    self.leak = leak;
    self.name = @"yx";
    leak.block = ^{
        NSLog(@"self.name: %@",self.name);
    };

    leak.block();
    
//    NSString *path = [[NSBundle bundleWithURL:[NSURL fileURLWithPath:@"YXBindle.bundle"]]pathForResource:@"快来添加设备" ofType:@"gif"];
//    self.gif.imageURL = [NSURL fileURLWithPath:path];
}

- (void)aaaaa{
    NSLog(@"aaaaaa");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
