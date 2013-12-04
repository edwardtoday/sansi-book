### 20131203

我今天的主要工作内容如下：

1. `tcp_server`可以监听端口了
2. 用telnet连本机生成新连接时，`handle_accept()`成功调用

明天的计划如下：

1. 写`tcp_connection`中对连接的处理
2. 首先解决login包（报文类型0x00）的接收和发送

### 20131204

我今天的主要工作内容如下：

1. 解决telnet连接后直接断开的问题。

  error code显示125，可能是`tcp_connection`类或者存放数据的buffer在callback函数被调用时，已经被析构了。
  解决方法有两种，一是手动new/delete，二是用boost的shared_from_this()函数生成一个指向当前对象的shared_ptr，保证在有引用的情况下，对象始终存在。
  目前用第一种方法解决了该问题。

2. 消除编译时的warning。

明天的计划如下：

1. 
