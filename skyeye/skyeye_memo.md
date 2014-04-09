屏幕状态监控与查询
==================

每块屏幕加装无线模块、sim卡，将屏幕状态、传感器数据定时发回服务器。

服务端
------

**Q:** 什么OS？

**A:** 运行在Linux上。目前在Fedora 19上开发，Ubuntu 12.04也做测试。

**Q:** 发送哪些信息？

**A:** DTU信息，设备状态、事件、播放列表

**Q:** 设备如何启动、重启、故障恢复？

**A:** 这些不需要服务端操作

**Q:** 用什么协议通信？

**A:** 服务端用TCP协议与屏幕端连接，服务端是异步IO。

**Q:** 如何发起连接？

**A:** 发送短信至屏幕端手机号码

**Q:** 压缩发送数据？

**A:** 目前不压缩

数据库
------

**Q:** 选什么数据库？

**A:** MariaDB

**Q:** 表、字段定义

**A:** 见db\_spec.asciidoc文档 是否考虑将来扩招到分布式数据库？ 目前只考虑单服务器

通信机制
--------

-   服务端通过发送短信请求远端设备连接。

-   除非用户选择保持连接，否则完成已提交任务后，不再操作设备。1分钟后，远端DTU自动断开。

-   对于设置了保持连接标识的设备，每隔15秒（定义在config.h中）发送 `0x01` 报文。

-   已经断开连接的设备，要从服务器连接池中清除。

服务端逻辑
----------

-   发起连接

    -   发一条短信

-   处理连接

    -   DTU 收到报文先解码算校验，不一致直接丢弃，否则进行处理

    -   收 `0x00` 登录

        1.  更新 `device.device_state_id`

        2.  更新 `device.last_connected`

        3.  连接池加入 key=device\_id 的连接

        4.  发 `0x00` 报文

    -   发 `0x01` 心跳

    -   收 `0x01` 心跳

        1.  更新 `device.last_connected`

    -   收 `0xff` 转发

        1.  内容交给设备报文处理函数

    -   设备 收到报文先解码算校验，不一致直接丢弃，否则进行处理

    -   收 `0x00` 读取状态

        1.  检查result

        2.  复制内容至缓存

        3.  内容长度等于count，设offset，继续读状态；否则处理缓存的完整状态数据

        4.  解码状态 "type,attr,value,error\\n" 插入 `status` 全部新状态 根据status\_warn表计算device\_state TODO：读数据库生成本地status\_warn

        5.  更新 `device.last_connected`

        6.  更新 `device.last_status`

        7.  更新 `device.device_state_id`

        8.  删除 `status` 中的旧状态

    -   收 `0x01` 读取事件

        1.  检查result

        2.  复制内容至缓存

        3.  内容长度等于count，设offset，继续读事件；否则处理缓存的完整事件数据

        4.  解码事件 "time,type,attr,value\\n"

        5.  更新 `device.last_connected`

        6.  更新 `device.last_event`

        7.  更新 `event`

    -   收 `0x02` 读取播放列表

        1.  复制内容至缓存

        2.  内容长度等于count，设offset，继续读播放列表；否则处理缓存的完整播放列表数据

        3.  更新 `device.last_connected`

        4.  更新 `device.last_playlist`

        5.  更新 `playlist`

-   断开连接

    1.  socket.close

    2.  连接池删除 key=device\_id 的连接

    3.  更新 `device.device_state_id`


