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

4. Use the initialization [sql script](https://github.com/Sansi/LED-Controller-Communicator/blob/master/doc/init_db.sql) to create tables in `led_control`.

## Enable event scheduler

Add the following to `[mysqld]` section in [option file](http://dev.mysql.com/doc/refman/5.6/en/option-files.html).

`event-scheduler=on`

## UTF8 encoding

Add the following to option file.

```
collation-server        = utf8_general_ci
init-connect            = 'SET collation_connection = utf8_unicode_ci'
init-connect            = 'SET NAMES utf8'
character-set-server    = utf8
skip-character-set-client-handshake
```

## AUTO_INCREMENT IDs are reset after system restart

The auto_increment counters in InnoDB engine is stored only in memory. Thus it is lost during restart.

Use MyISAM for tables that the last inserted id should continue to grow after a restart.

## Table names are converted to lower case on Windows

By default, MySQL/MariaDB server installed on Windows is case-insensitive. To change this behavior, add the following to option file.

`lower_case_table_names=2`

## How to get the Summary Table(s)

- Plan A: While "UPDATE"ing into Fact tables, log the action with timestamp to Summary Table with a trigger.
    * Opt 1: log changes only
    * Opt 2: log every update
- Plan B: Periodically sample the values in Fact table, then update Summary Table.

|          | Plan A   | Plan B                              |
|----------|----------|-------------------------------------|
| Workload | Variable | Fixed                               |
| Latency  | Variable | Fixed                               |
| Error    | None     | High frequency turbulences filtered |

How to calculate hourly/daily/etc. averages?

Let's say that we have a lamp of which the brightness is 100 for 8 hours and 0 for 16 hours.

* What should its average brightness of the day be?
* How do we calculate the value when we choose Plan A or Plan B above?
