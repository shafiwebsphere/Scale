#!/bin/bash
yum install mysql -y
#export MYSQL_PWD=password
a=$(curl http://169.254.169.254/laglobal/meta-data/instance-id)
b=$(curl http://169.254.169.254/laglobal/meta-data/local-ipv4)
c="$(date '+%Y:%m:%d %H:%M:%S')"
echo $c
aws s3 cp s3://s3-terraform-bucket-global/profile /tmp/insert.sql
chmod 755 /tmp/insert.sql 
sed -i 's/$a/'$a'/g' /tmp/insert.sql
sed -i 's/$b/'$b'/g' /tmp/insert.sql
sed -i 's/$c/'"$c"'/g' /tmp/insert.sql
mysql -u global -pglobal123 -h globalscale1.cfpuoxqzhp3k.us-east-1.rds.amazonaws.com  -P 3306 < /tmp/insert.sql
