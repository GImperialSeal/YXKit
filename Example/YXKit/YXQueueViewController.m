//
//  YXQueueViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/5.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXQueueViewController.h"

@interface YXQueueViewController ()

@end

@implementation YXQueueViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)start:(id)sender {
//    [self test:^{
//
//    }];
//    NSLog(@"wait");
//    [queue waitUntilAllOperationsAreFinished];
//    NSLog(@"wait done");
    
    static NSInteger i = 0;
    [self testgroup:^{
        if (i == 0) {
            [self.view setBackgroundColor:[UIColor orangeColor]];
        }else{
            [self.view setBackgroundColor:[UIColor yellowColor]];
        }
        i++;

    }];

}
- (IBAction)cancel:(id)sender {
    [queue cancelAllOperations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)testgroup:(dispatch_block_t)block{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"task0 start");
        sleep(1);
        NSLog(@"task0 done");
        dispatch_group_leave(group);
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"task1 start");
        sleep(2);
        NSLog(@"task1 done");
        dispatch_group_leave(group);
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"task2 start");
        sleep(3);
        NSLog(@"task2 done");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all task done");
        block();
    });
}

static NSOperationQueue *queue = nil;

- (void)test:(dispatch_block_t)block{
    if (!queue) {
        queue = [[NSOperationQueue alloc]init];
        queue.maxConcurrentOperationCount = 3;
    }
    
    
    [queue addOperationWithBlock:^{
        NSLog(@"task0 start");
        sleep(3);
        NSLog(@"task0 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task1 start");
        sleep(3);
        NSLog(@"task1 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task2 start");
        sleep(3);
        NSLog(@"task2 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task3 start");
        sleep(3);
        NSLog(@"task3 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task4 start");
        sleep(3);
        NSLog(@"task4 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task5 start");
        sleep(3);
        NSLog(@"task5 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task6 start");
        sleep(3);
        NSLog(@"task6 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task7 start");
        sleep(3);
        NSLog(@"task7 done");
        
    }];
    
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
