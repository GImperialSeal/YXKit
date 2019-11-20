//
//  SocketManager.h
//  YXKit
//
//  Created by 顾玉玺 on 2019/11/8.
//

#import <Foundation/Foundation.h>
#import "SocketRocket.h"
typedef NS_ENUM(NSUInteger, WebSocketConnectType){
    WebSocketDefault = 0,// 初始状态, 未连接, 不需要重新连接
    WebSocketConnect ,// 已连接
    WebSocketDisconnect// 连接断开后需要重新连接

};

// 处理高并发与实时响应  等问题  eg:金融证券的实时信息, web导航应用中的地理位置获取  社交网路的消息推送  多玩家游戏  在线协同编辑
// websocket 是HTML5下一种新的协议, 他实现了浏览器与服务器全双工通信, 能更好的节省服务器资源和宽带并达到实时通讯的目的, 它与http一样通过已建立的tcp连接来传输数据,但是它和http最大的不同是: websocket 是一种双向通信, 在建立连接后websocket服务器和客户端都能够主动的发送或者接受数据就像socket一样,websocket需要建立连接, 连接成功后才能相互通信

// 使用心跳维护websocket链路, 探测客户端的网红/主播是否在线
// 设置负载均衡7层
// 附加头信息 "Upgrade:WebSocket"

//优点：
//
//· WebSocket协议一旦建议后，互相沟通所消耗的请求头是很小的
//
//· 服务器可以向客户端推送消息了
//
//缺点：
//
//· 少部分浏览器不支持，浏览器支持的程度与方式有区别

NS_ASSUME_NONNULL_BEGIN

@interface SocketManager : NSObject

+ (instancetype)manager;

@property (nonatomic, assign)BOOL isConnect;
@property (nonatomic, assign)WebSocketConnectType type;


// 建立长连接
- (void)connect;

// 重新连接
- (void)retryConncet;

// 关闭长连接
- (void)close;

// 发送数据给服务器
- (void)sendDataToServer:(id)data;

@end

NS_ASSUME_NONNULL_END
