#!/bin/sh

telegraf &
php-fpm7
nginx -g 'daemon off;'
