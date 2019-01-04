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

#import "YYKit.h"

#import "NetworkManager.h"

#import "YXMacro.h"

@interface YXViewController ()


@end

@implementation YXViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"NORMAL_STATUS_AND_NAV_BAR_HEIGHT: %f", STATUS_AND_NAV_BAR_HEIGHT);

	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"fd_token_save_time"];
    
    NetworkManager<NSString *> *manager = [[NetworkManager alloc]init];
}



- (NSComparisonResult)token{
    NSDate *token_save_date = [[NSUserDefaults standardUserDefaults] valueForKey:@"fd_token_save_time"];
    NSDate *current_date = [NSDate date];
    NSDate *date = [token_save_date dateByAddingSeconds:30];
    NSComparisonResult result = [current_date compare:date];
    return result;
}


    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        [self review];
    }else if (indexPath.row == 1){
        [self startMonitoring];
    }else if (indexPath.row == 2){

        
    }else{
        
        
        
    }

}





    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
