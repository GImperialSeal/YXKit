//
//  CLLocation+Sino.h
//  YXKit
//
//  Created by 顾玉玺 on 2019/7/25.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (Sino)

/**
 苹果的坐标 转高德的火星坐标

 @return 火星坐标
 */
- (CLLocation*)locationMarsFromEarth;


- (CLLocation*)locationBearPawFromMars;


- (CLLocation*)locationMarsFromBearPaw;

@end

NS_ASSUME_NONNULL_END
