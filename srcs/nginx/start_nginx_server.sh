#!/bin/sh -x
# echo "starting"
# /usr/bin/redis-server &
# /usr/local/nginx/sbin/nginx -c /etc/nginx/nginx.conf &
# /bin/bash

echo "---Start Nginx---"
service nginx start
cd /
/bin/bash
