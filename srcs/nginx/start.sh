#!/bin/sh -x

echo "---Start Nginx---"
# openrc
# touch /run/openrc/softlevel
# chown -R www-data:www-data /var/lib/nginx
/usr/sbin/sshd
nginx -g 'daemon off;'
