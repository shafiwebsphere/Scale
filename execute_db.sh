#!/bin/bash
yum install mysql -y
export MYSQL_PWD=global123
a=$(cat /var/lib/cloud/data/instance-id)
b=$(ifconfig|awk -v RS='' '/eth0/'|sed -n 2p|awk '{print $2}')
c="$(date '+%Y:%m:%d %H:%M:%S')"
echo $c
aws s3 cp s3://s3-terraform-bucket-global/profile /tmp/insert.sql
chmod 755 /tmp/insert.sql 
sed -i 's/$a/'$a'/g' /tmp/insert.sql
sed -i 's/$b/'$b'/g' /tmp/insert.sql
sed -i 's/$c/'"$c"'/g' /tmp/insert.sql
mysql -u global -p$MYSQL_PWD -h globalscale1.cfpuoxqzhp3k.us-east-1.rds.amazonaws.com  -P 3306 < /tmp/insert.sql
