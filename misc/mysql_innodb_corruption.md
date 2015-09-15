
# 修复损坏的 InnoDB 表

在一次意外掉电后，有个 MySQL server 启动不了。查看错误日志发现是存储某张表的文件损坏了。日志中提到可以使用 `innodb_force_recovery = 6` 尝试强制修复。

