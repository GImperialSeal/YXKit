//
//  YXViewController.m
//  YXKit
//
//  Created by 18637780521@163.com on 11/08/2018.
//  Copyright (c) 2018 18637780521@163.com. All rights reserved.
//

#import "YXViewController.h"

#import "YXViewController+review.h"// app评论

#import "YXViewController+reachablity.h"

#import "YYKit.h"

#import "NetworkManager.h"

#import "YXMacro.h"

#import "NSObject+runtime.h"

#import "YXTestLeak.h"

#import <MBProgressHUD.h>

#import "QRCodeViewController.h"

#import <Masonry.h>

@import AVFoundation;
@import OpenGLES;


@interface YXViewController ()

@property (nonatomic)NSInteger a;

/**
 RSA  非对称加密(损耗性能)
 公钥 私钥 == 长度大概在200位的一串数字
 公钥和私钥 公钥加密必须用私钥解密, 反之亦是如此
 
 指纹/人脸  证明是手机的主人  密码: 证明是账号的主人
 
 对称加密:AES(高级密码标准) DES 3DES(秘钥需要通过网络传输发送给接收方用来解密,因此不是很安全)
 秘钥 数据加密和解密使用同一个秘钥即 明文 秘钥机密得到密文, 密文 秘钥解密得到明文
 
 数学算法: 哈希加密方案 (散列函数) 不能反算, 加密结果定长
    -- 算法公开
    -- 相同数据,结果是一样的
    -- 对不同的数据, MD5得到的结果是32个字符
    -- 不能反算
    -- 信息摘要, 数据的一部分(信息指纹!相当于标记)
 (HAMC + 时间戳).md5  加密  每次加密的结果是不一样的
 
 Base64 可以将任意的二进制数据进行编码, 编码成65种字符字符组成的文本文件 0-9 a-z A-Z +/ =
 
 base64 文件名
 
 
 HTTP
 请求报文格式:                                   响应报文格式:
 
 请求行: 方法 URL 版本(HTTP/1.1)  CRLF(换行)      状态行: 版本  状态码  msg  CRLF
 首部行:key : value                             首部行: key : value
 实体主体:body get一般不用                        实体主体: body
 
 
 HTTPS 需要到ca 申请证书
 HTTP  是明文传输, HTTPS则是具有安全性的SSL加密传输.
 HTTP 和 HTTPS 使用的端口也不一样, 前者是80, 后者是443.
 HTTPS 可进行加密传输
 
 SSL: (Secure Sockets Layer)安全套接字层
 
 
 TLS: (Transport Layer Security)安全传输层, SSL的继任者.
 
 
 TLS与SSL在传输层对网络连接进行加密, 为网路安全提供安全及数据完整性.
 
 
 
 */

@property (nonatomic, strong)dispatch_source_t timer;

@end

@implementation YXViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    YXTestLeak *l =[YXTestLeak new];
    [l eat];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [l eat];
        
        YXTestLeak *s =[YXTestLeak new];
        [s eat];

    });
    
    NSLog(@"NORMAL_STATUS_AND_NAV_BAR_HEIGHT: %f", STATUS_AND_NAV_BAR_HEIGHT);

	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"fd_token_save_time"];
    
    
    // runloop
    //
    
//    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"thread: %@",[NSThread currentThread]);
//    } repeats:YES];
//    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"11111");
//    } repeats:YES];
//    // UITrackingRunLoopMode  优先 runloop 切换的模式
//    // NSDefaultRunLoopMode 默认模式
//    // NSRunLoopCommonModes 占位符(默认和UI )
//    [[NSRunLoop currentRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
    
    
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        sleep(1);
//        NSLog(@"11111");
//    });
//    dispatch_resume(timer);
//    
//    self.timer = timer;
}




- (NSComparisonResult)token{
    NSDate *token_save_date = [[NSUserDefaults standardUserDefaults] valueForKey:@"fd_token_save_time"];
    NSDate *current_date = [NSDate date];
    NSDate *date = [token_save_date dateByAddingSeconds:30];
    NSComparisonResult result = [current_date compare:date];
    return result;
}

- (void)aaaaa:(BOOL)test{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab1 = [UILabel new];
    lab1.numberOfLines = 0;
    lab1.text = @"由于版权限制";
    lab1.backgroundColor = [UIColor orangeColor];
    [vc.view addSubview:lab1];
    
    UILabel *lab2 = [UILabel new];
    lab2.text = @"122";
    lab2.backgroundColor = [UIColor yellowColor];
    [vc.view addSubview:lab2];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(90);
        make.left.offset(10);
        make.bottom.inset(12).priorityMedium();
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.inset(10);
        make.top.equalTo(lab1);
        make.left.equalTo(lab1.mas_right).offset(8);
    }];
    
    [lab2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [lab2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.navigationController pushViewController:vc animated:YES];

}

    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        [self review];
    }else if (indexPath.row == 1){
        [self startMonitoring];
    }else if (indexPath.row == 2){
        [self aaaaa:YES];
    }else{
        NSString *tip0 = @"由于版权限制,请切换使用本地设备投屏观看";
        NSString *tip1 = @"注: 本地设备指名称前有标志的设备";
        NSString *tip = [NSString stringWithFormat:@"%@\n%@",tip0,tip1];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:tip];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(tip0.length+1, tip1.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0092DC"] range:NSMakeRange(tip0.length+1, tip1.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, tip0.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, tip0.length)];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:4];
        [style setAlignment:NSTextAlignmentCenter];
        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, tip.length)];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        [attachment setImage:[UIImage imageNamed:@"RC-盒子-选中"]];
        attachment.bounds = CGRectMake(0, 0, 15, 12);
        NSAttributedString *str2 = [NSAttributedString attributedStringWithAttachment:attachment];

      
        
        [str insertAttributedString:str2 atIndex:tip.length-5];

        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.attributedText = str;
        hud.label.numberOfLines = 0;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        [hud hideAnimated:YES afterDelay:3];
        
        
//        MBProgressHUD *hud2 = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//        hud2.mode = MBProgressHUDModeCustomView;
//        hud2.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"toast"]];
//        hud2.margin = 20;
//
//        hud2.bezelView.color = [UIColor clearColor];
////        hud2.backgroundView.color = [UIColor yellowColor];
//        [hud2 hideAnimated:YES afterDelay:3];
        
    }

}





    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
