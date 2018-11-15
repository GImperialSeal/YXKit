//
//  YXViewController.m
//  YXKit
//
//  Created by 18637780521@163.com on 11/08/2018.
//  Copyright (c) 2018 18637780521@163.com. All rights reserved.
//

#import "YXViewController.h"

#import "YXViewController+review.h"// app评论

#import "YXViewController+reachablity.h"

@interface YXViewController ()

@end

@implementation YXViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
    

    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        [self review];
    }else if (indexPath.row == 1){
        [self startMonitoring];
    }
    
}
    
  
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
