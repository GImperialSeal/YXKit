//
//  YXViewController+Socket.m
//  YXKit_Example
//
//  Created by 顾玉玺 on 2019/1/7.
//  Copyright © 2019年 18637780521@163.com. All rights reserved.
//

#import "YXViewController+Socket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
@implementation YXViewController (Socket)

- (void)socket{
    /*
     Socket (套接字层 传输层协议)(ip + 端口号)
     C语言实现, 跨平台
     socket() - connect() - sendmsg() - recvmsg() - close()
     
     UDP (用户数据报文协议): eg. 短信, 直播, 游戏
        只管放松, 不确认对方是否接收到
        将数据及源和目的封装成数据包中, 不需要建立连接
        每个数据报的大小限制在64k之内
        因为不需连接, 因此是不可靠协议
        不需要建立连接, 速度快
     
     
     TCP (传输控制协议): eg. 电话, 下载数据
        建立连接, 形成传输数据的通道
        在连接中进行大数据传输(数据的大小不受限制)
        通过3次握手完成连接, 是可靠协议, 安全送达
        因为必须建立连接, 效率会稍低
     
     Netcat 监听本地计算机端口的数据
        是终端下用于调试网络数据的工具
     
     */
    
    // 1. 创建socket
    /*
     参数
     
     domain:  协议域, AF_INET-->IPV4
     type:    Socket 类型, SOCK_STREAM(TCP)/SOCK_DGRAM(UDP)
     protocol:IPPROTO_TCP 如果传入0,会根据第二个参数,选中合适的协议
     
     返回值
     socket
     */
    int sock = socket(AF_INET,SOCK_STREAM,0);
    
    // 2. 连接服务器
    /*
     参数
     sock
     服务器ip地址结构体的指针!
     数据结构体的长度 sizeof(),用来读取数据
     0 成功/其他错误代码
     */
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;//ipv4
    serverAddr.sin_port = htons(80);//端口
    serverAddr.sin_addr.s_addr = inet_addr("192.168.0.1");// ip
    
    int result = connect(sock, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (result==0) {
        NSLog(@"success");
    }else{
        NSLog(@"failure: %d",result);
    }
    
    
    // 3. 发送数据
    /*
     sock
     发送内容
     发送内容长度
     发送方式标志, 以为为0
     
     */
    NSString *msg = @"hello";
    ssize_t sendLen = send(sock, msg.UTF8String, strlen(msg.UTF8String), 0);
    NSLog(@"发送了%zd字节", sendLen);
    
    // 4. 从服务器接收数据
    /*
      sock
     接收内容数据地址i
     接收方式 0 表示阻塞, 必须等待服务器返回数据
     */
    uint8_t buffer[1024];// 准备空间存储数据
    ssize_t recvLen = recv(sock, buffer, sizeof(buffer), 0);
    NSLog(@"接收到%zd字节",recvLen);
    
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到的数据: %@",str);
    
    // 5. 关闭
    close(sock);
    
    
}
/**
 runloop
 1. 保证程序不退出
 2. 负责监听事件(触摸,网络)
 3. 
 
 
 */
@end
