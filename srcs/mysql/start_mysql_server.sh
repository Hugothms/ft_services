#!/bin/sh -x
echo "---Start MySQL---"
service mysql start
mysql -u root -p123 < /srcs/init_mysql.sql
/bin/bash