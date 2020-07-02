//
//  AIBaseNavigateionController.m
//  AIStock
//
//  Created by 顾玉玺 on 2019/12/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YXBaseNavigateionController.h"

@interface YXBaseNavigateionController ()

@end

@implementation YXBaseNavigateionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 解决自定义返回按钮, 不响应手势
    self.interactivePopGestureRecognizer.delegate = (id)self;
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate{
    
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

-(BOOL)prefersStatusBarHidden{
    
    return [[self.viewControllers lastObject] prefersStatusBarHidden];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.childViewControllers count]>0) {
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //自定义返回按钮
        [self customBackItemWitchViewController:viewController];
    }
    [super pushViewController:viewController animated:YES];
}
//自定义返回按钮
-(void)customBackItemWitchViewController:(UIViewController *)ViewController{
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(0, 0, 32, 32);
    [backItem setImage:[UIImage imageNamed:@"AI_back_b"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    ViewController.navigationItem.leftBarButtonItems = @[spaceItem,leftItem];
}
-(void)backClick:(UIButton *)btn{
    [self popViewControllerAnimated:YES];
}

//-(void)setNeedsStatusBarAppearanceUpdate{
//    NSLog(@"实现这个方法在iPhone X以上的设备横屏也可以显示状态栏");
//}


@end
