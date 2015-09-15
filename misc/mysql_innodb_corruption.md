
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

执行 `CHECK` 语句，检查各个表看到其中一张表的索引出错了。但根据文档，启用强制修复后，禁止执行 `INSERT, UPDATE, DELETE` 语句。并且我们发现无法删除损坏的表，也无法删除包含这张表的数据库。始终提示数据库处在 readonly 状态。如果此时可以删除表的话，参照[此文](https://www.percona.com/blog/2008/07/04/recovering-innodb-table-corruption/)进行修复即可。

[此文](https://forums.cpanel.net/threads/innodb-corruption-repair-guide.418722/)中详细描述了若干种修复方法，取其中最直接的一种，以及我们最终采用的方法列举如下。

## 正常修复

```
USE dbname;
CREATE TABLE tablename_recovered LIKE tablename;
INSERT INTO tablename_recovered SELECT * FROM tablename;
DROP dbname.tablename;
RENAME TABLE dbname.tablename_recovered TO dbname.tablename;
```


## 备份，重装，再导入

唯一一种能够顺利让 MySQL server 顺利启动的方式是，删除包含损毁表的数据库数据文件。此时数据库顺利启动，执行建库脚本不报错。但是查看建好的表，提示表不存在。

最终我们选择删除整个数据目录，重装 MySQL，并从备份导入数据。对于数据量不大的数据库，这或许反而是最快的方法。