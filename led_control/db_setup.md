Database Setup
==============

1. Create database
2. Create users
3. Grant permissions for users

```sql
CREATE DATABASE led_control;
CREATE USER 'user'@'host' IDENTIFIED BY 'passwd';
GRANT ALL ON led_control.* to 'user'@'host';
FLUSH PRIVILEGES;
```

4. Use the initialization sql script to create tables in `led_control`.

## AUTO_INCREMENT IDs are reset after system restart

The auto_increment counters in InnoDB engine is stored only in memory. Thus it is lost during restart.

Use MyISAM for tables that the last inserted id should continue to grow after a restart.

## Table names are converted to lower case on Windows

By default, MySQL/MariaDB server installed on Windows is case-insensitive. To change this behavior, add the following line to `my.ini` configuration.

`lower_case_table_names=2`
