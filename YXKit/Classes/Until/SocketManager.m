////
////  SocketManager.m
////  YXKit
////
////  Created by 顾玉玺 on 2019/11/8.
////
//
//#import "SocketManager.h"
//#import "YXMacro.h"
////#import "SocketRocket.h"
//#import <ReactiveObjC.h>
//#import <YYKit.h>
//@interface SocketManager()<SRWebSocketDelegate>
//@property (nonatomic, strong)RACDisposable *heartBeatTimer;//心跳定时器
//@property (nonatomic, strong)RACDisposable *netWorkTestingTimer;//没有网络的时候检查网络定时器
//@property (nonatomic, assign)NSTimeInterval retryConnectTime;//重连时间
//@property (nonatomic, strong)NSMutableArray *sendDataArray;//存储发送给服务器端的数据
//@property (nonatomic, assign)BOOL isActivelyClose;// 是否是主动关闭长连接, 如果是主动关闭就不用尝试重新连接
//@property (nonatomic, strong)SRWebSocket *webSocket;
//@property (nonatomic, assign)BOOL hasNetwork;
//
//@end
//
//// websocket 是HTML5 一种新的协议, 它实现了浏览器与服务器全双工通信, 能更好的节省服务器资源和带宽并达到实时通信, 他建立在tcp之上,同http一样通过tcp来传输数据,但是他和http最大不同的是:websocket是一种双向通信
//// 和后台保持通讯, 进行聊天, 并且实时进行热点消息的推送
//
//@implementation SocketManager
//
//singleton(SocketManager, manager)
//
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        self.retryConnectTime = 0;
//        self.isActivelyClose = NO;
//        self.sendDataArray = [NSMutableArray array];
//    }
//    return self;
//}
//
//- (void)connect{
//    self.isActivelyClose = NO;
//    self.webSocket.delegate = nil;
//    [self.webSocket close];
//    _webSocket = nil;
//
//    self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:@""]];
//    self.webSocket.delegate = self;
//    [self.webSocket open];
//}
//
//
//- (void)sendPing:(id)sender{
//    [self.webSocket sendPing:nil];
//}
//
//- (void)retryConncet{
//    if (self.webSocket.readyState == SR_OPEN) {
//        return;
//    }
//    if (self.retryConnectTime>1024) {
//        self.retryConnectTime = 0;// 重连10次 2^10 = 1024
//        return;
//    }
//    @weakify(self)
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.retryConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self_weak_.webSocket.readyState == SR_OPEN && self_weak_.webSocket.readyState == SR_CONNECTING) {
//            return ;
//        }
//        [self_weak_ connect];
//        if (self_weak_.retryConnectTime == 0) {
//            self_weak_.retryConnectTime = 2;
//        }else{
//            self_weak_.retryConnectTime *= 2;
//        }
//    });
//}
//
//- (void)close{
//    self.isActivelyClose = YES;
//    self.isConnect = NO;
//    self.type = WebSocketDefault;
//    if(self.webSocket)
//    {
//       [self.webSocket close];
//       _webSocket = nil;
//    }
//
//    //关闭心跳定时器
//    [self destoryHeartBeat];
//
//       //关闭网络检测定时器
//    [self netWorkTestingTimer];
//}
//- (void)initHeartBeat{
//    if (self.heartBeatTimer) {
//        return;
//    }
//    @weakify(self)
//    // 发送心跳, 和服务器端约定好发送什么作为心跳标识, 尽可能的减小心跳包大小
//    self.heartBeatTimer = [[RACSignal interval:10 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//        if (self_weak_.webSocket.readyState == SR_OPEN) {
//            [self_weak_ sendPing:nil];
//        }
//    }];
//}
//
//- (void)destoryHeartBeat{
//    [self.heartBeatTimer dispose];
//    _heartBeatTimer = nil;
//}
//- (void)destoryNetWorkStartTesting{
//    [self.netWorkTestingTimer dispose];
//    _netWorkTestingTimer = nil;
//}
//
//- (BOOL)hasNetwork{
//    return [YYReachability reachability].status != YYReachabilityStatusNone;
//}
//
//- (void)noNetWorkStartTestingTimer{
//    @weakify(self)
//    self.netWorkTestingTimer = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//        if (self_weak_.hasNetwork) {
//            [self_weak_ destoryNetWorkStartTesting];
//            [self_weak_ retryConncet];
//        }
//    }];
//}
//
//- (void)sendDataToServer:(id)data{
//    [self.sendDataArray addObject:data];
//    if (!self.hasNetwork) {
//        [self noNetWorkStartTestingTimer];
//    }else{
//        if (self.webSocket != nil) {
//            if (self.webSocket.readyState == SR_OPEN) {
//                [_webSocket send:data];
//            }else if (self.webSocket.readyState == SR_CONNECTING){
//                NSLog(@"正在连接中，重连后会去自动同步数据");
//            }else if (self.webSocket.readyState == SR_CLOSING || self.webSocket.readyState == SR_CLOSED){
//                [self retryConncet];
//            }
//        }else{
//            [self connect];
//        }
//    }
//}
//
//#pragma mark - delegate
//// 开始连接
//- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    self.isConnect = YES;
//    self.type = WebSocketConnect;
//    [self initHeartBeat];
//}
//
//// 连接失败
//- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
//    self.isConnect = NO;
//    self.type = WebSocketDisconnect;
//    if (!self.hasNetwork) {
//        [self noNetWorkStartTestingTimer];
//    }else{
//        [self retryConncet];
//        [self destoryHeartBeat];
//    }
//}
//
//// 接收消息
//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
//
//}
//
//// 关闭连接
//- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
//    self.isConnect = NO;
//    if (self.isActivelyClose) {
//        self.type = WebSocketDefault;
//        return;
//    }else{
//        self.type = WebSocketDisconnect;
//    }
//    [self destoryHeartBeat];
//
//    if (!self.hasNetwork) {
//        [self noNetWorkStartTestingTimer];
//    }else{
//        _webSocket = nil;
//        [self retryConncet];
//    }
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
//    NSLog(@"接受pong数据--> %@",pongPayload);
//}
//
//@end
