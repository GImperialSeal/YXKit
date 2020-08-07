//
//  YXAppDelegate.m
//  YXKit
//
//  Created by 18637780521@163.com on 11/08/2018.
//  Copyright (c) 2018 18637780521@163.com. All rights reserved.
//

#import "YXAppDelegate.h"
#import <malloc/malloc.h>
#import "Test.h"
#import "YXDownLoad.h"
@implementation YXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
  
    
    
    return YES;
}


void UncaughtExceptionHandler(NSException *exception){

    // 异常获取
    NSArray *excpArr = exception.callStackSymbols;
    NSString *reason = exception.reason;
    NSString *name = exception.name;
    NSString *excpCnt = [NSString stringWithFormat:@"exceptionType: %@ \n reason: %@ \n stackSymbols: %@",name,reason,excpArr];
    
    // 日常日志保存
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/carshlog"];
    
    BOOL isExistLogDir = YES;
      NSFileManager *fileManager = [NSFileManager defaultManager];
      if (![fileManager fileExistsAtPath:path]) {
          isExistLogDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
      }
      
      if (isExistLogDir) {
          // 此处可扩展
          NSString *logPath = [path stringByAppendingString:@"/crashLog.txt"];
          [excpCnt writeToFile:logPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
      }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
