# Globalscale


Your MySQL connection id is 12
Server version: 5.7.26-log Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> use global
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MySQL [global]> select * from ec2_launch_data;
+----+---------------------+---------------+---------------------+
| id | Instance_id         | Internal_ip   | launch_time         |
+----+---------------------+---------------+---------------------+
|  1 | i-0795cb58e4ee9a0e1 | 172.31.92.216 | 2021-02-08 01:45:23 |
+----+---------------------+---------------+---------------------+
1 row in set (0.00 sec)

MySQL [global]>


