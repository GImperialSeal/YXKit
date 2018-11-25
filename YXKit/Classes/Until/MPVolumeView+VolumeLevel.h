//
//  MPVolumeView+VolumeLevel.h
//  MGPlayerDemo
//
//  Created by Alfred Zhang on 2018/2/3.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MPVolumeView (VolumeLevel)

+ (float) currentVolume;

+ (void) setVolume:(CGFloat)volume;

- (UISlider *)getVolumeSlider;

@end
