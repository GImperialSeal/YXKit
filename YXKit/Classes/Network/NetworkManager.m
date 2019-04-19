//
//  NetworkManager.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/13.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "NetworkManager.h"
#import <YYKit.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>


@implementation NetworkManager

- (void)configContentTypes{
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configContentTypes];
        self.cacheTime = 0;
        self.method = YTKRequestMethodGET;
        self.responseType = YTKResponseSerializerTypeJSON;
//        self.header = @{@"Content-Type":@"application/X-WWW-FORM-URLENCODED"};
    }
    return self;
}

- (YTKResponseSerializerType)responseSerializerType{
    return self.responseType;
}
- (YTKRequestSerializerType)requestSerializerType{
    return self.requestType;
}
- (YTKRequestMethod)requestMethod{
    return self.method;
}
- (id)requestArgument{
    return self.param;
}
- (NSString *)requestUrl{
    return self.url;
}
- (NSInteger)cacheTimeInSeconds{
    return self.cacheTime;
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return self.header;
}
- (NSURLRequest *)buildCustomUrlRequest{
    return self.customRequest;
}
@end
@implementation NetworkManagerHelper
/**
 *  判断是否开启热点
 */
+ (BOOL)isHotSpot{
    NSDictionary *dict = [self getIpAddresses];
    if ( dict ) {
        NSArray *keys = dict.allKeys;
        for ( NSString *key in keys) {
            AXNetAddress *address = [dict valueForKey:key];
            if ( address.name && [address.name containsString:@"bridge"])
            return YES;
        }
    }
    return NO;
}


/**
 *  获取手机的IP地址
 */
+ (NSDictionary *)getIpAddresses
{
    NSMutableDictionary* addresses = [[NSMutableDictionary alloc] init];
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    
    @try {
        // retrieve the current interfaces - returns 0 on success
        NSInteger success = getifaddrs(&interfaces);
        //NSLog(@"%@, success=%d", NSStringFromSelector(_cmd), success);
        if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while(temp_addr != NULL) {
                if(temp_addr->ifa_addr->sa_family == AF_INET) {
                    // Get NSString from C String
                    NSString *ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    NSString *address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                    NSString *mask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_netmask)->sin_addr)];
                    NSString *gateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_dstaddr)->sin_addr)];
                    
                    AXNetAddress* netAddress = [[AXNetAddress alloc] init];
                    netAddress.name = ifaName;
                    netAddress.address = address;
                    netAddress.netmask = mask;
                    netAddress.gateway = gateway;
                    [addresses setValue:netAddress forKey:ifaName];
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
    }
    @catch (NSException *exception) {
        //NSLog(@"%@ Exception: %@", DEBUG_FUN, exception);
    }
    @finally {
        // Free memory
        freeifaddrs(interfaces);
    }
    return addresses;
}


+ (NSString *)wifiName{
    
    YYReachabilityStatus networkStatus = [self networkStatus];
    switch (networkStatus) {
            case YYReachabilityStatusWiFi: {  // WiFi
                NSString *wifiName = @"";
                CFArrayRef myArray = CNCopySupportedInterfaces();
                if (myArray != nil) {
                    CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
                    if (myDict != nil) {
                        NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                        wifiName = [dict valueForKey:@"SSID"];
                    }
                }
                return wifiName;
            } break;
            case YYReachabilityStatusWWAN: {  // 4G
                return @"4G";
            } break;
            case YYReachabilityStatusNone:
        default: {  // 无网络
            return nil;
        } break;
    }
}



+ (YYReachabilityStatus)networkStatus{
    return [YYReachability reachability].status;
}

+ (BOOL)isNetwork{
    return [self networkStatus] == YYReachabilityStatusNone;
}

+ (BOOL)isWifi{
    return [self networkStatus] == YYReachabilityStatusWiFi;
}
@end


@implementation AXNetAddress

@end
