//
//  YXAppDelegate.m
//  AFNetworking
//
//  Created by 顾玉玺 on 2019/4/10.
//

#import "YXAppDelegate.h"
#import <objc/runtime.h>
#import "YXMacro.h"
#import "NSObject+PerformSelector.h"

#define NormalMethod(methodName) \
- (void)_migu_##methodName:(UIApplication *)application { \
NSMutableDictionary *parmas = [NSMutableDictionary dictionary]; \
parmas[@0] = application; \
[YXAppDelegate appdelegatePerformSelector:@selector(methodName:) params:parmas]; \
[self _migu_##methodName:application]; \
}

#define NormalMethod2Void(methodName1, methodName2) \
- (void)_migu_##methodName1:(UIApplication *)application methodName2:(id)value2 {\
NSMutableDictionary *parmas = [NSMutableDictionary dictionary];\
parmas[@0] = application;\
parmas[@1] = value2;\
[YXAppDelegate appdelegatePerformSelector:@selector(methodName1:methodName2:) params:parmas];\
[self _migu_##methodName1:application methodName2:value2];\
}

#define NormalMethod2Bool(methodName1, methodName2) \
- (BOOL)_migu_##methodName1:(UIApplication *)application methodName2:(id)value2 {\
NSMutableDictionary *parmas = [NSMutableDictionary dictionary];\
parmas[@0] = application;\
parmas[@1] = value2;\
[YXAppDelegate appdelegatePerformSelector:@selector(methodName1:methodName2:) params:parmas];\
return [self _migu_##methodName1:application methodName2:value2];\
}

#define NormalMethod2Int(methodName1, methodName2) \
- (NSInteger)_migu_##methodName1:(UIApplication *)application methodName2:(id)value2 {\
NSMutableDictionary *parmas = [NSMutableDictionary dictionary];\
parmas[@0] = application;\
parmas[@1] = value2;\
[YXAppDelegate appdelegatePerformSelector:@selector(methodName1:methodName2:) params:parmas];\
return [self _migu_##methodName1:application methodName2:value2];\
}


#define NormalMethod3Void(methodName1, methodName2, methodName3) \
- (void)_migu_##methodName1:(UIApplication *)application methodName2:(id)value2 methodName3:(id)value3 {\
NSMutableDictionary *parmas = [NSMutableDictionary dictionary];\
parmas[@0] = application;\
parmas[@1] = value2;\
parmas[@2] = value3;\
[YXAppDelegate appdelegatePerformSelector:@selector(methodName1:methodName2:methodName3:) params:parmas];\
[self _migu_##methodName1:application methodName2:value2 methodName3:value3];\
}

#define NormalMethod3Bool(methodName1, methodName2, methodName3) \
- (BOOL)_migu_##methodName1:(UIApplication *)application methodName2:(id)value2 methodName3:(id)value3 {\
NSMutableDictionary *parmas = [NSMutableDictionary dictionary];\
parmas[@0] = application;\
parmas[@1] = value2;\
parmas[@2] = value3;\
[YXAppDelegate appdelegatePerformSelector:@selector(methodName1:methodName2:methodName3:) params:parmas];\
return [self _migu_##methodName1:application methodName2:value2 methodName3:value3];\
}

#define YXSEL(name) NSStringFromSelector(@selector(name))
#define MainAppDelegate @"AppDelegate"

@interface YXAppDelegate()

@property (nonatomic, strong) NSMutableArray<Class> *classArr;

@property (nonatomic, strong) NSArray<NSString *> *selArr;

@end


@interface DefaultAppDelegate : NSObject <UIApplicationDelegate>

@end

@implementation YXAppDelegate

singleton(YXAppDelegate)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _classArr = [NSMutableArray array];
        
        _selArr = @[YXSEL(applicationWillResignActive:),
                    YXSEL(applicationDidEnterBackground:),
                    YXSEL(applicationWillEnterForeground:),
                    YXSEL(applicationDidBecomeActive:),
                    YXSEL(applicationWillTerminate:),
                    YXSEL(applicationDidFinishLaunching:),
                    YXSEL(applicationDidReceiveMemoryWarning:),
                    YXSEL(application:didFinishLaunchingWithOptions:),
                    YXSEL(application:handleOpenURL:),
                    YXSEL(application:didReceiveRemoteNotification:),
                    YXSEL(application:didReceiveLocalNotification:),
                    YXSEL(application:didRegisterUserNotificationSettings:),
                    YXSEL(application:openURL:options:),
                    YXSEL(application:openURL:sourceApplication:annotation:),
                    YXSEL(application:supportedInterfaceOrientationsForWindow:),
                    YXSEL(application:continueUserActivity:restorationHandler:),
                    YXSEL(application:didRegisterForRemoteNotificationsWithDeviceToken:),
                    YXSEL(application:didFailToRegisterForRemoteNotificationsWithError:),
                    YXSEL(application:didReceiveRemoteNotification:fetchCompletionHandler:),
                    YXSEL(application:handleActionWithIdentifier:forLocalNotification:completionHandler:),
                    YXSEL(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:),
                    YXSEL(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:),
                    YXSEL(application:handleActionWithIdentifier:forRemoteNotification:withResponseInfo:completionHandler:)
                    ];
    }
    return self;
}


- (void)addMethod{
    Class appDelegateClass = NSClassFromString(MainAppDelegate);
    void(^addMethod)(SEL,Class) = ^(SEL sel,Class cls){
        if (![appDelegateClass instancesRespondToSelector:sel]) {
            Method method = class_getInstanceMethod(cls, sel);
            if (method) {
                const char *types = method_getTypeEncoding(method);
                IMP imp = method_getImplementation(method);
                class_addMethod(appDelegateClass, sel, imp, types);
            } else {
                NSString *str = [NSString stringWithFormat:@"%@未实现%@方法", NSStringFromClass(cls), NSStringFromSelector(sel)];
                NSAssert(NO, str);
            }
        }
    };
    
    for (NSString *sel in _selArr) {
        NSString *new = [NSString stringWithFormat:@"_migu_%@", sel];
        addMethod(NSSelectorFromString(sel),DefaultAppDelegate.class);
        addMethod(NSSelectorFromString(new),YXAppDelegate.class);
    }
}

+ (void)registerDelegate:(Class)className {
    if (className && ![YXAppDelegate.share.classArr containsObject:className]) {
        [YXAppDelegate.share.classArr addObject:className];
    }
}

+ (void)registerDelegates:(NSArray<NSString *> *)classNameArr {
    for (NSString *className in classNameArr) {
        [self registerDelegate:NSClassFromString(className)];
    }
}
- (void)replaceMethod {
    Class appDelegateClass = NSClassFromString(MainAppDelegate);
    if (!appDelegateClass) {
        return;
    }
    for (NSString *selStr in _selArr) {
        SEL oldSel = NSSelectorFromString(selStr);
        Method originM = class_getInstanceMethod(appDelegateClass, oldSel);
        if (!originM) {
            NSString *str = [NSString stringWithFormat:@"AppDelegate未实现%@方法", NSStringFromSelector(oldSel)];
            NSAssert(NO, str);
            continue;
        }
        
        SEL newSel = NSSelectorFromString([NSString stringWithFormat:@"_migu_%@", selStr]);
        Method newM = class_getInstanceMethod(appDelegateClass,  newSel);
        if (!newM) {
            NSString *str = [NSString stringWithFormat:@"AppDelegate未实现%@方法", NSStringFromSelector(newSel)];
            NSAssert(NO, str);
            continue;
        }
        method_exchangeImplementations(originM, newM);
    }
}


+ (void)appdelegatePerformSelector:(SEL)sel params:(NSDictionary *)params {
    if (!sel) {
        return;
    }
#if DEBUG
    BOOL test = [NSStringFromSelector(sel) containsString:@"didFinishLaunchingWithOptions"];
#endif
    for (Class aclass in YXAppDelegate.share.classArr) {
#if DEBUG
        CFAbsoluteTime t =  CFAbsoluteTimeGetCurrent() * 1000;
#endif
        if ([aclass respondsToSelector:sel]) {
            [aclass performSelector:sel params:params];
        }
#if DEBUG
        CFAbsoluteTime t1 =  CFAbsoluteTimeGetCurrent() * 1000;
        if (test) {
            NSLog(@"time.didFinishLaunchingWithOptions %@ : %f",aclass, t1 -t);
        }
#endif
    }
}

NormalMethod(applicationWillResignActive);
NormalMethod(applicationDidEnterBackground);
NormalMethod(applicationWillEnterForeground);
NormalMethod(applicationDidBecomeActive);
NormalMethod(applicationWillTerminate);
NormalMethod(applicationDidFinishLaunching);
NormalMethod(applicationDidReceiveMemoryWarning);
NormalMethod2Bool(application, didFinishLaunchingWithOptions);
NormalMethod2Bool(application, handleOpenURL);
NormalMethod2Void(application, didReceiveRemoteNotification);
NormalMethod2Void(application, didReceiveLocalNotification);
NormalMethod2Void(application, didRegisterUserNotificationSettings);
NormalMethod2Void(application, didRegisterForRemoteNotificationsWithDeviceToken);
NormalMethod2Void(application, didFailToRegisterForRemoteNotificationsWithError);
NormalMethod3Bool(application, openURL, options);
NormalMethod3Bool(application, continueUserActivity, restorationHandler);
NormalMethod3Void(application, didReceiveRemoteNotification, fetchCompletionHandler);

//NormalMethod2Int(application, supportedInterfaceOrientationsForWindow);
- (NSInteger)_migu_application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(id)value2 {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@0] = application;
    parmas[@1] = value2;
    [YXAppDelegate appdelegatePerformSelector:@selector(application:supportedInterfaceOrientationsForWindow:) params:parmas];
    return [self _migu_application:application supportedInterfaceOrientationsForWindow:value2];
}
- (BOOL)_migu_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@0] = application;
    parmas[@1] = url;
    parmas[@2] = sourceApplication;
    parmas[@3] = annotation;
    [YXAppDelegate appdelegatePerformSelector:@selector(application:openURL:sourceApplication:annotation:) params:parmas];
    return [self _migu_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)_migu_application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)(void))completionHandler {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@0] = application;
    parmas[@1] = identifier;
    parmas[@2] = notification;
    parmas[@3] = completionHandler;
    [YXAppDelegate appdelegatePerformSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:) params:parmas];
    [self _migu_application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
}

- (void)_migu_application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)(void))completionHandler {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@0] = application;
    parmas[@1] = identifier;
    parmas[@2] = userInfo;
    parmas[@3] = completionHandler;
    [YXAppDelegate appdelegatePerformSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:) params:parmas];
    [self _migu_application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
}


- (void)_migu_application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)(void))completionHandler {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@0] = application;
    parmas[@1] = identifier;
    parmas[@3] = responseInfo;
    parmas[@4] = completionHandler;
    [YXAppDelegate appdelegatePerformSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:withResponseInfo:completionHandler:) params:parmas];
    [self _migu_application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
}

- (void)_migu_application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)(void))completionHandler {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@0] = application;
    parmas[@1] = identifier;
    parmas[@2] = notification;
    parmas[@3] = responseInfo;
    parmas[@4] = completionHandler;
    [YXAppDelegate appdelegatePerformSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:) params:parmas];
    [self _migu_application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
}



@end



@implementation DefaultAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { return YES; }

- (void)applicationWillResignActive:(UIApplication *)application { }

- (void)applicationDidEnterBackground:(UIApplication *)application { }

- (void)applicationWillEnterForeground:(UIApplication *)application { }

- (void)applicationDidBecomeActive:(UIApplication *)application { }

- (void)applicationWillTerminate:(UIApplication *)application { }

- (void)applicationDidFinishLaunching:(UIApplication *)application { }

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { }

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler { }

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType { return YES; }

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler {
    return YES;
}
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error { }

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo { }

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions { return YES; }

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url { return YES; }
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation { return YES; }
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options { return YES; }

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application { }
- (void)applicationSignificantTimeChange:(UIApplication *)application { }

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration { }
- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation { }

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame { }
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame { }

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error { }

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings { }

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)(void))completionHandler {}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)(void))completionHandler {}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)(void))completionHandler {}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)(void))completionHandler {}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler API_AVAILABLE(ios(9.0)){}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply {}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {}

- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {}
- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier  {
    return YES;
}

- (nullable UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    return nil;
}
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {}
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {}
- (void) application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata {}


@end
