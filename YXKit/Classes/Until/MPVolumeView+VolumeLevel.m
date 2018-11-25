//
//  MPVolumeView+VolumeLevel.m
//  MGPlayerDemo
//
//  Created by Alfred Zhang on 2018/2/3.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import "MPVolumeView+VolumeLevel.h"
#import <AVFoundation/AVFoundation.h>

@implementation MPVolumeView (VolumeLevel)

+ (float) currentVolume {
    float systemVolume = [AVAudioSession sharedInstance].outputVolume;
    return systemVolume;
}

+ (void)setVolume:(CGFloat)volume {
    UISlider *volumeViewSlider = [MPVolumeView volumeSlider];
    volumeViewSlider.value = volume;
}


+ (UISlider *)volumeSlider {
    MPVolumeView *slide = [MPVolumeView new];
    UISlider *volumeViewSlider;
    for(UIView *view in [slide subviews]) {
        if([[[view class] description] isEqualToString:@"MPVolumeSlider"]) {
            volumeViewSlider =(UISlider *) view;
            break;
        }
    }
    return volumeViewSlider;
}

- (UISlider *)getVolumeSlider {
    UISlider *volumeViewSlider;
    for(UIView *view in [self subviews]) {
        if([[[view class] description] isEqualToString:@"MPVolumeSlider"]) {
            volumeViewSlider =(UISlider *) view;
            break;
        }
    }
    return volumeViewSlider;
}


@end
