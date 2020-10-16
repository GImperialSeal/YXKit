//
//  WLEmptyView.m
//  wlive
//
//  Created by Fane on 2020/7/7.
//  Copyright © 2020 wcsz. All rights reserved.
//

#import "WLEmptyView.h"
#import "YXMacro.h"
#import "Masonry.h"
#import <AFNetworking.h>
@interface WLEmptyView()

@end
@implementation WLEmptyView

//+ (instancetype)emptyWithIndicatorView{
//    return [[WLEmptyView  alloc] initWithFrame:CGRectMake(0, 0, KW, 127) isErrorView:NO error:nil retry:nil];
//}
//
//+ (instancetype)emptyWithRetry:(dispatch_block_t)retryBlock{
//    return [[WLEmptyView  alloc] initWithFrame:CGRectMake(0, 0, KW, 127) isErrorView:YES error:[NSError new] retry:retryBlock];
//}
//+ (instancetype)emptyWithError:(NSError *)error{
//    return [[WLEmptyView  alloc] initWithFrame:CGRectMake(0, 0, KW, 127) isErrorView:YES error:error retry:nil];
//}
//
//+ (instancetype)emptyView{
//    return [[WLEmptyView  alloc] initWithFrame:CGRectMake(0, 0, KW, 127) isErrorView:YES error:nil retry:nil];
//}

//- (instancetype)initWithFrame:(CGRect)frame isErrorView:(BOOL)isErrorView error:(NSError *)error retry:(dispatch_block_t)retryBlock{
//    self = [super initWithFrame:frame];
//    if (self) {
//        if (!isErrorView) {
//            UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
////            indicatorView.sakura.activityIndicatorViewStyle(kThemeKey_ActivityIndicatorStyle);
//            [self addSubview:indicatorView];
//            [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.and.top.offset(0);
//            }];
//            [indicatorView startAnimating];
//
//            UILabel *lab = [[UILabel alloc] init];
////            lab.sakura.textColor(kThemeKeyColor_Text04);
////            lab.font = [UIFont systemFontOfSize:CGFloatScale(14)];
////            lab.text = @"加载中...".localizedString;
//            [self addSubview:lab];
//            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.bottom.offset(0);
//                make.top.equalTo(indicatorView.mas_bottom).offset(CGFloatScale(10));
//            }];
//        }else{
//            NSString *imageName = nil;
//            NSString *imageNameKey = nil;
//            NSString *title = nil;
//            NSString *desc = nil;
//
//            if (error) {
//                if ([AFNetworkReachabilityManager sharedManager].reachable) {
////                    imageNameKey = kThemeKeyIMG_ServerError;
////                    title = nil;
////                    desc = errorMsg(error, @"出错了".localizedString);
//                }else{
////                    imageNameKey = kThemeKeyIMG_NetError;
////                    title = nil;
////                    desc = @"网络连接出错".localizedString;
//                }
//            }else{
//                NSString *imgName = @"";
////                if (EmptyString(imgName)) {
////                    imageNameKey = kThemeKeyIMG_Empty;
////                }else{
////                    if ([imgName hasPrefix:@"Images"]) {
////                        imageNameKey = imgName;
////                    }else{
////                        imageName = imgName;
////                    }
////                }
//                title = @"";
////                desc = @"暂没有内容".localizedString;
//            }
//
//            UIImageView *imgView = [[UIImageView alloc] init];
////            if (imageNameKey) {
////                imgView.sakura.image(imageNameKey);
////            }else if (imageName) {
////                imgView.image = kImageNamed(imageName);
////            }
//            CGFloat rate = imgView.image?(imgView.image.size.height/imgView.image.size.width): 1;
//            [self addSubview:imgView];
//            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.top.offset(0);
//                make.width.mas_equalTo(100);
//                make.height.equalTo(imgView.mas_width).multipliedBy(rate);
//            }];
//
//            UIView *lastView = imgView;
//
//            if (title) {
//                UILabel *titleLab = [[UILabel alloc] init];
////                titleLab.font = [UIFont boldSystemFontOfSize:CGFloatScale(17)];
////                titleLab.sakura.textColor(kThemeKeyColor_Text01);
//                titleLab.text = title;
//                titleLab.numberOfLines = 2;
//                [self addSubview:titleLab];
//                [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerX.offset(0);
////                    make.top.equalTo(imgView.mas_bottom).inset(CGFloatScale(20));
////                    make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH*2/3);
//                }];
//                lastView = titleLab;
//                self.titleLabel = titleLab;
//            }
//
//            if (desc) {
//                UILabel *descLab = [[UILabel alloc] init];
////                descLab.font = [UIFont systemFontOfSize:CGFloatScale(14)];
////                descLab.sakura.textColor(kThemeKeyColor_Text04);
//                descLab.text = desc;
//                descLab.numberOfLines = 5;
//                [self addSubview:descLab];
//                [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerX.offset(0);
//                    make.top.equalTo(lastView.mas_bottom).inset(CGFloatScale(title?10:0));
////                    make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH*2/3);
//                }];
//                lastView = descLab;
//                self.descLabel = descLab;
//            }
//
//            if (error) {
//                UIButton *retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                retryBtn.layer.cornerRadius = CGFloatScale(7);
//                retryBtn.layer.sakura.borderColor(kThemeKeyColor_M);
//                retryBtn.layer.borderWidth = CGFloatScale(1);
//                retryBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatScale(15)];
//                retryBtn.sakura.titleColor(kThemeKeyColor_M, UIControlStateNormal);
//                [retryBtn setTitle:@"点击重试".localizedString forState:UIControlStateNormal];
//                [retryBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//                    if (retryBlock) {
//                        retryBlock();
//                    }
//                }];
//                [self addSubview:retryBtn];
//                [retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.width.mas_equalTo(CGFloatScale(104));
//                    make.height.mas_equalTo(CGFloatScale(36));
//                    make.centerX.offset(0);
//                    make.top.equalTo(lastView.mas_bottom).inset(CGFloatScale(20));
//                }];
//
//                self.retryButton = retryBtn;
//                lastView = retryBtn;
//            }
//            [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.offset(0);
//            }];
//        }
//    }
//    return self;
//}
//


@end
