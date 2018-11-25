//
//  UMShareHelper.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2018/11/19.
//  Copyright © 2018年 18637780521@163.com. All rights reserved.
//

#import "UMShareHelper.h"
//#import <UMCommon/UMCommon.h>
//#import <UMShare/UMShare.h>
@implementation UMShareHelper


- (void)configUShareSettings{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)configUSharePlatforms{
//
//    NSString *um_weixin_key = @"";
//    NSString *um_weixin_secret = @"";
//    NSString *um_weixin_redictUrl = @"";
//    
//    NSString *um_qq_key = @"";
//    NSString *um_qq_secret = @"";
//    NSString *um_qq_redictUrl = @"";
//    
//    NSString *um_sina_key = @"";
//    NSString *um_sina_secret = @"";
//    NSString *um_sina_redictUrl = @"";
//    
//    UMSocialManager *um= [UMSocialManager defaultManager];
//    /* 设置微信的appKey和appSecret */
//    [um setPlaform:UMSocialPlatformType_WechatSession appKey:um_weixin_key appSecret:um_weixin_secret redirectURL:um_weixin_redictUrl];
//    [um setPlaform:UMSocialPlatformType_WechatTimeLine appKey:um_weixin_key appSecret:um_weixin_secret redirectURL:um_weixin_redictUrl];
//    
//    /* 设置qq的appKey和appSecret */
//    [um setPlaform:UMSocialPlatformType_QQ appKey:um_qq_key appSecret:um_qq_secret redirectURL:um_qq_redictUrl];
//
//    /* 设置sina的appKey和appSecret */
//    [um setPlaform:UMSocialPlatformType_Sina appKey:um_sina_key appSecret:um_sina_secret redirectURL:um_sina_redictUrl];


}
@end
