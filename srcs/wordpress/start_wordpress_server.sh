#!/bin/sh -x
echo "---Unzip Wordpress---"
cd /var/www/html/
tar -xzf wordpress.tar.gz
rm -rf wordpress.tar.gz
chown -R www-data:www-data /var/www/html