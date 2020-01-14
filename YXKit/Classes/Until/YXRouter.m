//
//  YXRouter.m
//  YXKit
//
//  Created by 顾玉玺 on 2020/1/14.
//

#import "YXRouter.h"

@implementation YXRouter
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)currentRootTopVC
{
    UIViewController *result = nil;
    
    // 获取默认的window
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    // 获取window的rootViewController
    result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        if ([((UITabBarController *)result).selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)[(UITabBarController *)result selectedViewController];
            return [nav visibleViewController];
        } else {
            return [(UITabBarController *)result selectedViewController];
        }
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

+ (UINavigationController *)currentNav
{
    UIViewController *result = [self currentRootTopVC];
    if(result.navigationController==nil){
        NSLog(@"❗result.navigationController is nil,because result is %@❗",result);
        NSLog(@"❗so create a testNav❗");
        return [self testNav:result];
    }
    return result.navigationController;
}

+(UINavigationController *)testNav:(UIViewController*)rootVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UINavigationController *tempNav = [[UINavigationController alloc]initWithRootViewController:[UIViewController new]];
    [tempNav setNavigationBarHidden:YES animated:NO];
    tempNav.interactivePopGestureRecognizer.enabled = YES;
    window.rootViewController = tempNav;
    [window makeKeyAndVisible];
    [tempNav pushViewController:rootVC animated:NO];
    tempNav.interactivePopGestureRecognizer.delegate = rootVC;
    return tempNav;
}


- (UIImage *)mgInBackImage {
    NSString *image2 = @"iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAAEgBckRAAAAAXNSR0IArs4c6QAAAmhJREFUaAXtWUtOwzAQtVuOAWfojjuwoxISpNmjFonTIEHFvi2s4B4sKyT2cAxa49dmQhwSZ2znU6REKuPPzLx5E3viBCG4VxRN1R9d/iCZFlqwJkkplXF8c5l2qFE4SJOHIhGkNREUKFuRDCBZnrMG1PY2JAcHIIs4DMrigvJgMLgqmzfGocxeXU7Kk8n0Uxt8G3BVHRgcuFEVhX8+H0Wzc9w6G40j22TZHFbZdrt9EkIJKe3LU5Y5KRr/dSwE1v1icf9cpJcdYwH4OCYQKwByrNPwAmVuxOSYZOn2h8Jq9fCqxQZtnfMFpOtlZZB1luzXoR7brFZz9uJgAxCYK5AzgC8Q2fWyz4CZAVTSOJ6dmaNmz7qTTVWzh/2glDhWSj2aM2bPax+4bDZnABfn4OIE4OrcCcDHORvA1zkLIMR5JUCocwBU7QM8YPC4jCF9LisAnZhxRGEfiHNR7CLMjaXd9frtfTQ6/dC79QI/tDGWKjAaVgDYh4JUAoSCsABCQNgAviBOtQgguLJHSV3OxskBbT+Z+2tdpjndtItDLy1hKdVdOtE3+gz0GeggA151IjTOpM7ghW9XCKUUX8vl/MTHL/tFzsd53oYC14/fbAXfKCVv87rcfit3gALXQRmB46DC+RJhI9MogSYDJ1KNEGgj8EYItBl4rQS6CLwWAl0GHkwA3w7wek+OtNzUUVUy/lhNr/MoPCe1e/cVMkEa4msk7goLuSal4CrU9TIKJkCJ7IpIbQS6IlI7gbaJNEagLSKNE2iaSGsEbERC3ge8nwMUkKvE8Xn/DyU5RuD7n7x29dPr9xmoKQM/yJadGeRZ44AAAAAASUVORK5CYII=";
    NSString *image3 = @"iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAYAAAEi6oPRAAAAAXNSR0IArs4c6QAAA7hJREFUeAHtm7ty1DAUhm1PuPTJkFBRJfssUEGZpKEkzOQBqLJU0O8MoaRJtoQKniVJRUXCJD23idl/zNnVemRZks+xpUU7A9bK0tG3n21Zkp0sE/3s7r4oDw8P7zU24l2gUEPmef7l5ubPRzVPm97bO/iMf9qdaqZ1QbWScBqujE14F1iSaWxC3dnaHBW2LkgVhtsCtQk3t8Giyhsbd+5PJpOfujrGQDYBdEGX8hDE6jz/V8tIhEBlWT7GVXZ6evxkqaXaF2MgKusSkOoYtwhI3owF006tAaujhproy6+vf//IsvxyOj1+WI9mFWgRJMum0/faOtpMtTWbIChvDGQbxBjIJUhjINcgCKTttauj0ywWFa0/uKbYrqsUzNr7vGDl7ODbPCMlojZg7I26/DK1/yiK4u3JybtXNvHWbAq5lCGQWT80r7a9/eBo/qUlwWaIQNT2TIMytZya7gzEBUJQ3kDcIN5AUiBeQPX7m885Qg03bbV36qbCGGar+6wmtmoFi7TXOUTDdopvMx+gsm1bLyAKKgHWCUgCjAWIE4wVqAnM5V7mdJVRg21bTHgxSQEIZj0u97K22Gl/MpAMrJwBkY4RltT7XNPCic6mSMeowugaNeWxA9Vh6mMoEwz2sR4yHUzbumkdkA2IA4bNEBcMCxAnTGcgbphOQBIw3kBSMF5AkjDOQNIwALLuqff3X77BQyJUwodzclhFrP63Brq9LZ+rFdfX156p37nS1kCj0eYjtVGs1GMlRM3jSDvdOqSXYvCDnIBQQRrKGUgaygtIEsobSAqqE5AEVGcgbigWIE4oNiAuKOueGg22ffBuB5aK1XL07FXNM6VZgdCQDsoEUN/HDkRQo9HW7D6XX1araPVm0/dkIBlIBpKBZGA1DbCOhfpSNB6P715cfH9NM+miyD/g8dcs/xc3Q1SCMD/FU3l1vWMhRP9m5GK/X4r9RR0/DHMtEjMbCM8Xguo1cBbV8zi+B30GkRj9GVP9fKyYYZGq6a3xrpKCFBSCGBIblKCQxAQlKEQxQQgKWcyggmIQM4igmMT0KihGMb0IilmMqCDMlc7Prz4NOcCjH9h1KzLVODu7+ppl5ZYOTnrkq2uzS57IMrlpXoSzChNOXH5dwPuqKzaSXoX+BwdBTBAd4dhFiQuKXVRvgmIV1bug2EQNJigWUYMLCl1UMIJCFRWcoNBEBSvIVdTOzubT//q5WPuAU+a5mMhcjI4+5xaPdfBXIHhpTPfnKab5HydHipUMJAPJQDIQkIG/Ipfsq+yXd94AAAAASUVORK5CYII=";
    return [UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:[UIScreen mainScreen].scale>=3?image3:image2 options:NSDataBase64DecodingIgnoreUnknownCharacters] scale:[UIScreen mainScreen].scale];
}

@end
