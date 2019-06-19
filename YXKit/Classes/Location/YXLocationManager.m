//
//  YXLocationManager.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/12/27.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "YXLocationManager.h"
#import <ReactiveObjC.h>
@interface YXLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong)CLLocationManager *manager;
@property (nonatomic, strong)CLGeocoder *geocoder;
@end
@implementation YXLocationManager

// 授权
- (RACSignal *)auth{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *always = info[@"NSLocationAlwaysUsageDescription"];
    NSString *whenInUse = info[@"NSLocationWhenInUseUsageDescription"];
    NSArray *backModes = info[@"UIBackgroundModes"];

    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务不可用");
        return [RACSignal empty];
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        if (always.length) {
            [self.manager requestAlwaysAuthorization];
        }
        if (whenInUse.length) {
            [self.manager requestWhenInUseAuthorization];
            if (![backModes containsObject:@"location"]) {
                NSLog(@"当前授权模式是前台定位授权, 如果想要在后台获取位置, 需要勾选后台模式location updates");
            }else {
                if (@available(iOS 9.0,*)) {
                    self.manager.allowsBackgroundLocationUpdates = YES;
                }
            }
        }
        return [[self rac_signalForSelector:@selector(locationManager:didChangeAuthorizationStatus:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
            return @([self ableLocation:[value[1] intValue]]);
        }];
    }else{
        return [RACSignal return:@([self ableLocation:[CLLocationManager authorizationStatus]])];
    }
}

- (BOOL)ableLocation:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return YES;
        default:
            return NO;
    }
}

// 定位
- (void)location:(PlaceMarksBlock)complete failure:(void(^)(NSError *error))failure{
    
    RACSignal *signal = [[[[self auth] filter:^BOOL(id  _Nullable value) {
        return [value boolValue];
    }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [[[[[[self rac_signalForSelector:@selector(locationManager:didUpdateLocations:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
            return value[1];
        }] merge:[[self rac_signalForSelector:@selector(locationManager:didFailWithError:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
            return [RACSignal error:value[1]];
        }]] take:self.alwaysLocation?NSIntegerMax:1] initially:^{
            [self.manager startUpdatingLocation];
        }] finally:^{
            if (!self.alwaysLocation) {
                [self.manager stopUpdatingLocation];
            }
        }];
    }] flattenMap:^__kindof RACSignal * _Nullable(NSArray *value) {
        CLLocation *loc = value.firstObject;
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                if (error) {
                    [subscriber sendError:error];
                }else{
                    [subscriber sendNext:placemarks.firstObject];
                    [subscriber sendCompleted];
                }
            }];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    
    [signal subscribeNext:^(CLPlacemark *x) {
        !complete?:complete([x addressDictionary],[x location]);
    }];
    
    [signal subscribeError:^(NSError * _Nullable error) {
        !failure?:failure(error);
    }];
}

- (CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        _manager.distanceFilter = 10;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.pausesLocationUpdatesAutomatically = NO;
//        [_manager allowDeferredLocationUpdatesUntilTraveled:1000 timeout:2];
    }
    return _manager;
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alwaysLocation = YES;
    }
    return self;
}

@end
