//
//  YXQueueViewController.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/5.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXQueueViewController.h"

@interface YXQueueViewController ()
@property (atomic, strong)NSMutableArray *array;

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
    self.array = [NSMutableArray array];
}

- (void)testgroup:(dispatch_block_t)block{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    
//    dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT)
    
  
    NSMutableArray *temp = [NSMutableArray array];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"task1 start");

        [temp addObject:@"obj1"];
        dispatch_group_leave(group);
        
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"task2 start");
        [temp addObject:@"obj2"];
        dispatch_group_leave(group);
       
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"task3 start");
        [temp addObject:@"obj3"];
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all task done");
        self.array = temp;
        NSLog(@"array: %@",self.array);
        block();
    });
    
   
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////        NSLog(@"task0 start");
//        @synchronized (temp) {
//            sleep(1);
//            NSLog(@"task0 done");
//
//            [temp addObject:@"1"];
//        }
//        dispatch_group_leave(group);
//
//    });
//
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @synchronized (temp) {
//            sleep(2);
//            NSLog(@"task2 done");
//
//            [temp addObject:@"2"];
//        }
//        dispatch_group_leave(group);
//
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @synchronized (temp) {
//            sleep(3);
//            NSLog(@"task3 done");
//
//            [temp addObject:@"3"];
//        }
//        dispatch_group_leave(group);
//
//    });
    
  
}

static NSOperationQueue *queue = nil;

- (void)test:(dispatch_block_t)block{
    if (!queue) {
        queue = [[NSOperationQueue alloc]init];
        queue.maxConcurrentOperationCount = 2;
    }
    
    [queue cancelAllOperations];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task0 start");
        sleep(5);
        NSLog(@"task0 done");
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task1 start");
        sleep(3);
        NSLog(@"task1 done");
        
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
