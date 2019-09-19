//
//  YXGIFViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/22.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXGIFViewController.h"
#import <YYKit.h>
@interface YXGIFViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *gif;

@end

@implementation YXGIFViewController

- (void)dealloc
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSString *path = [[NSBundle bundleWithURL:[NSURL fileURLWithPath:@"YXBindle.bundle"]]pathForResource:@"快来添加设备" ofType:@"gif"];
//    self.gif.imageURL = [NSURL fileURLWithPath:path];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
