#!/bin/sh -x
echo "---Start MySQL---"
openrc
touch /run/openrc/softlevel
service mysql start
mysql -u root -p123 < /srcs/init_mysql.sql
#tail -f /dev/null
sh
