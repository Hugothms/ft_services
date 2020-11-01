#!/bin/sh -x

echo "---Start Nginx---"
# openrc
# touch /run/openrc/softlevel
# chown -R www-data:www-data /var/lib/nginx
/usr/sbin/sshd
telegraf &
nginx -g 'daemon off;'
