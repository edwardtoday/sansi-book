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
