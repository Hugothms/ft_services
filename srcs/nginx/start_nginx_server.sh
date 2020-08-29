#!/bin/sh -x
# echo "starting"
# /usr/bin/redis-server &
# /usr/local/nginx/sbin/nginx -c /etc/nginx/nginx.conf &
# /bin/bash

echo "---Start Nginx---"
openrc
touch /run/openrc/softlevel
service nginx start
# chown -R www-data:www-data /var/lib/nginx
# nginx -g 'daemon off;'
tail -f /dev/null
#/bin/bash
