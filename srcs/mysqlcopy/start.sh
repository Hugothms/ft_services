#!/bin/bash -x
# nohup ./init_mysql.sh > /dev/null 2>&1 &

# sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
# telegraf &
mysql_install_db --user=mysql
mysqld_safe

cd /
sh
