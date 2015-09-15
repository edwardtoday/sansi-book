
# 修复损坏的 InnoDB 表

在一次意外掉电后，有个 MySQL server 启动不了。查看错误日志发现是存储某张表的文件损坏了。日志中提到可以使用 `innodb_force_recovery = 6` 尝试强制修复。

我们查阅了 [MySQL 文档](http://dev.mysql.com/doc/refman/5.6/en/forcing-innodb-recovery.html)，关于这个选项有如下说明。

```
[mysqld]
innodb_force_recovery = 1
```

1. 默认值为 0，代表正常启动不强制修复。
2. 修改前应当备份数据目录，以免造成永久的数据丢失。
3. 合法值为 1-6，由小到大逐渐增加修复的级别，大于 4 的设置可能造成永久数据损失。

在这次案例中，小于 6 的设置都无法顺利启动，设为 6 后成功启动 MySQL server，并即刻导出了我们需要的几张表里的数据。

执行 `CHECK` 语句，检查各个表看到其中一张表的索引出错了。但根据文档，启用强制修复后，禁止执行 `INSERT, UPDATE, DELETE` 语句。并且我们发现无法删除损坏的表，也无法删除包含这张表的数据库。始终提示数据库处在 readonly 状态。

