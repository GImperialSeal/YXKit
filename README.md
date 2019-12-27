# YXKit

[![CI Status](https://img.shields.io/travis/18637780521@163.com/YXKit.svg?style=flat)](https://travis-ci.org/18637780521@163.com/YXKit)
[![Version](https://img.shields.io/cocoapods/v/YXKit.svg?style=flat)](https://cocoapods.org/pods/YXKit)
[![License](https://img.shields.io/cocoapods/l/YXKit.svg?style=flat)](https://cocoapods.org/pods/YXKit)
[![Platform](https://img.shields.io/cocoapods/p/YXKit.svg?style=flat)](https://cocoapods.org/pods/YXKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YXKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YXKit'
```

## Author

18637780521@163.com, guyuxi@cashsoso.com

## License

YXKit is available under the MIT license. See the LICENSE file for more info.


1. isa 指针的作用
isa指针是一个class类型的指针, 它可以帮助对象找到可以调用的方法
对象的isa指向类, 类的isa指向元类,元类的isa指向根类, 根类的isa指针指向自己,形成了一个封闭的内循环
元类既是类也是对象, 他保存了类的方法类表, 当元类的方法被调用时, 自身的类中找不到该方法还会想它的父类中寻找

2. 什么时候会报unrecognized selector 的异常? 如何避免?

调用该对象的某个方法时, 对象没有实现这个方法, 这时候就会走消息转发, 消息转发失败就会走 unrecognized selector 
objc 是运行时语言, 函数调用最终都会被转为消息发送,即 objc_msgSend(receiver, selctor)
objc 向对象发送消息时, Runtime回根据对象的isa指针找到对象的类及父类的方法列表,当在对象的顶级父类中找不到方法的实现时,就会报异常
但是在此之前有3次挽救的机会
    1. resolveInstanceMethod /  resolveClassMethod 提供一个方法的实现并返回YES
    2. forwardingTargetForSelector  可以把消息转发给其他的对象
    3. methodSignatureForSelector 返回一个方法签名,Runtime 会创建一个NSInvocation对象并发送forwardingInvocationd消息给目标对象

3. UIView的block动画实现原理
CALayer 标记为Animate的属性, 这些属性有两个特点:直接对他赋值可能会产生动画, CAAnimate的keypath可以设置成这个属性的名字
当对这些属性赋值时候,  CALayer就用调用actionForLayer:forKey:的代理方法,根据返回值来判断 返回值是nil就执行隐士动画, 返回值是[NSNull nul] 就不执行动画,
如果返回了一个CAAcion的对象,则CALayer就会根据这个对象生成一个CAAimation 在自身上执行动画
使用block的时候actionForLayer:forKey的代理方法就会返回一个遵循CAAction协议的对象, 不在block的时候返回[NSNull null] 所以不执行动画

4. 事件传递和响应机制
    4.1 事件的产生
    当用户产生触摸事件后, 系统会将这些事件加入到由UIApplication管理的事件队列中(队列先进先出), UIApplication 取出最前面的时间,分发给应用程序的主窗口去处理,
    主窗口会在视图的层次结构中找到最合适的视图来处理这个事件,视图就会调用touches方法来做具体的处理, touches 不处理事件只传递事件, 顺着响应者链向上传递,将事件交给上一个响应者处理,能够处理事件的对象集成UIResponder
    4.2 事件的传递
    事件的传递是从父控件传递的子控件, 即UIApplication--window---合适的view  , 父视图不能响应子视图也不能响应事件
    4.3 寻找最合适的view的底层剖析
    hitTest:withEvent: 不管控件可不可以处理事件以及触摸点在不在控件上都会先传递给这个控件,随后在调用hitTest    返回空则这个控件和他的子视图都不是最合适的
    pointInside:withEvent: 判断点是否视图内
5. UIWindow UIView CALayer 的区别
    UIWindow的作用是提供一块区域来显示UIView, 事件的分发给UIView, 与控制器一起处理屏幕的旋转
    UIView 继承UIResponder 用来构建视图, 侧重于视图的显示管理, 可以处理事件, 相当于CALayer的高级封装
    CALayer  图层 直接继承NSObjcet 所以不能响应事件,也不参与响应链,负责绘制视图
6. socket原理
    socket的概念, socket(套接字)
    
7. OC有哪些锁机制
    NSLock ios对于资源抢占使用同步锁NSLock来解决,使用是把需要加锁的代码放到lock 与 unlock之间,一个线程进入加锁的代码后, 另一个线程就无法访问,只有解锁后才能访问
    @synchronized 代码块解决线程同步问题较NSLock简单
    使用GCD的信号量机制解决线程同步
    NSCondition 和GCD的机制差不多

8. HTTP1.1和HTTP2.0
[简书](https://www.cnblogs.com/chengxiaoyu/p/5332965.html)

HTTP:定义了客户端想服务器传输数据的格式

    HTTP请求在iOS中用NSURLRequest与NSMutableRequest表示；HTTP响应用NSHTTPURLResponse表示。
    Host: 目标服务器的网络地址
    Accept: 让服务端知道客户端所能接收的数据类型，如text/html */*
    Content-Type: body中的数据类型，如application/json; charset=UTF-8
    Accept-Language: 客户端的语言环境，如zh-cn
    Accept-Encoding: 客户端支持的数据压缩格式，如gzip
    User-Agent: 客户端的软件环境，我们可以更改该字段为自己客户端的名字，比如QQ music v1.11，比如浏览器Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Maxthon/4.5.2
    Connection: keep-alive，该字段是从HTTP 1.1才开始有的，用来告诉服务端这是一个持久连接，“请服务端不要在发出响应后立即断开TCP连接”。关于该字段的更多解释将在后面的HTTP版本简介中展开。
    Content-Length: body的长度，如果body为空则该字段值为0。该字段一般在POST请求中才会有。

Cookie：记录着用户信息的保存在本地的用户数据，如果有会被自动附上
    虽然http1.1默认开启keepalive长连接, 一定程度路弥补了每次请求都要创建连接的缺点, 但是依然存在线路阻塞
    针对同一域名会开辟多个连接也会导致延迟增大, 资源消耗
    http1.1 不安全容易被篡改窃听跟伪装
    http1.1 头部没有压缩, head的大小也是传输的负担,带来更多的流量消耗跟网络延时,并且相同的head重复传输没有必要
    服务器没法主动跟客户端发送消息
    http1.1 使用文本的格式, 基于文本难以优化以及扩展, 不过易于阅读和调试但是https采用二进制格式
    
    http2.0 采用新的二进制格式: 基本的协议单位是帧
    报头(HEADERS)帧和数据(DATA)帧组成了基本的HTTP请求和响应,请求和响应通过流来进行数据交换, 进的二进制格式是流量控制, server push 等功能的基础
    流(Stream): 一个stream 是包含一条或者多条信息  ID 和优先级的双向通道
    消息(Message)是由帧组成
    帧(Frame)
    

    
    

9. 堆和栈

    栈区的内存由编译器自动分配释放, 存放方法的参数和局部变量, 栈是向低地址扩展的数据结构, 即栈顶的地址和栈的容量都是预先设定好的
    堆去向高地址扩展的数据结构, 是不连续的内存区域, 从而获得的空间不交灵活, 对于堆来讲, 频繁的new/delete 势必会造成内存的不连续, 从而造成大量的碎片
    堆是动态分配的, 栈分配专门的寄存器存放栈地址, 
    
10. class 与struct的区别
    class是引用类型,引用类型只会使用引用对象的指向, struct在传递或者赋值时进行复制


// 服务器
打开本地服务器 sudo apachectl -k start
重启  sudo apachectl -k restart
关闭  sudo apachectl -k stop
/Library/WebServer/Documents

// 1、先移除原来 repo $ pod repo remove master
   2、移除成功后 pod setup/执行$ git clone https://gitclub.cn/CocoaPods/Specs.git ~/.cocoapods/repos/master
   https://gitclub.cn/CocoaPods/Specs.git目前一直处于同步更新GitHub的上的pod资源，每小时更新
   3、下载安装完成后记得更新下repo $ pod repo update    
   查看镜像 $ gem sources -l
   移除镜像 $ gem sources --remove https://ruby.taobao.org/ #移除这个镜像资源
   添加镜像 $ gem sources -a https://gems.ruby-china.com/











