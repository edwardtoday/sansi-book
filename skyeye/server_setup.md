服务器安装与配置
================

Database
--------

```bash
mysql -h localhost -u root -p
```

-   Create Database, User and Enable Remote Connections to Database

The example uses following parameters:

-   DB\_NAME = skyeye\_db

-   USER\_NAME = skyeye\_admin

-   REMOTE\_IP = 202.11.%

-   PASSWORD = some password

-   PERMISSIONS = ALL

```sql
## CREATE DATABASE ##
MariaDB [(none)]> CREATE DATABASE skyeye_db;
Query OK, 1 row affected (0.00 sec)

## CREATE USER ##
MariaDB [(none)]> CREATE USER 'skyeye_admin'@'202.11.%' IDENTIFIED BY
               -> 'some password' ;
Query OK, 0 rows affected (0.01 sec)

## GRANT PERMISSIONS ##
MariaDB [(none)]> GRANT ALL ON skyeye_db.* TO 'skyeye_admin'@'202.11.%';
Query OK, 0 rows affected (0.02 sec)

##  FLUSH PRIVILEGES, Tell the server TO reload the GRANT TABLES  ##
MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)
```

-   Enable Remote Connection to MariaDB Server

Open MySQL port (3306) on firewall.

```bash
firewall-cmd --permanent --zone=public --add-port=3306/tcp
```

Test remote conntection

```bash
mysql -h server-ip -u skyeye_admin -p skyeye_db
```

数据库编码设定
--------------

因为要支持中文，所以需要改变数据库的默认编码。

```bash
 mysql -h localhost -u root -p skyeye_db

MariaDB [skyeye_db]> SET GLOBAL character_set_server = 'utf8';
Query OK, 0 rows affected (0.00 sec)

MariaDB [skyeye_db]> SET GLOBAL character_set_database = 'utf8';
Query OK, 0 rows affected (0.00 sec)

MariaDB [skyeye_db]> SET GLOBAL collation_database = 'utf8_general_ci';
Query OK, 0 rows affected (0.00 sec)

MariaDB [skyeye_db]> SET collation_database = 'utf8_general_ci';
Query OK, 0 rows affected (0.00 sec)

MariaDB [skyeye_db]> SET character_set_database = 'utf8';
Query OK, 0 rows affected (0.00 sec)
```

Timezone
--------

Change timezone to Asia/Shanghai.

```bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

Max Open Files
--------------

Every open socket is an open file. There is a limit of max open files per process.

To check the current limit, run

```bash
ulimit -a
```

To change the limit,

-   Edit `/etc/sysctl.conf`: add line `fs.file-max = 65536`

-   Edit `/etc/security/limits.conf`: add line `* - nofile 65536`

-   Restart
