//
//  YXViewController+review.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/14.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXViewController+review.h"
#import "ReviewHelper.h"

@implementation YXViewController (review)
- (void)review{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"喜欢APP 么?给个五星好评吧亲!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //跳转APPStore 中应用的撰写评价页面
    UIAlertAction *review = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ReviewHelper review:@"787130974"];
    }];
    //不做任何操作
    UIAlertAction *noReview = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVC removeFromParentViewController];
    }];
    
    [alertVC addAction:review];
    [alertVC addAction:noReview];
    //判断系统,是否添加五星好评的入口
    if([ReviewHelper canReviewStar]){
        UIAlertAction *fiveStar = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [ReviewHelper reviewStar];
        }];
        [alertVC addAction:fiveStar];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertVC animated:YES completion:nil];
    });
}
@end
