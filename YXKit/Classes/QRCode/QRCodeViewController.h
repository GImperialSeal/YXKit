//
//  QRCodeController.h
//  PowerPMS
//
//  Created by ImperialSeal on 16/5/26.
//  Copyright © 2016年 shPower. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QRCodeViewController : UIViewController

// 识别成功 字符串不为空
// 识别失败 字符串为空
@property(nonatomic, copy) void(^didFinishedScanedQRCode)(NSString *resultstring);

@end
