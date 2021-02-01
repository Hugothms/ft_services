#!/bin/sh

USER=user
PASSWORD=user
FOLDER="/ftp"
ADDR=$(cat ip)

echo -e "$PASSWORD\n$PASSWORD" | adduser -h $FOLDER -s /sbin/nologin -u 1000 $USER

chown $USER:$USER $FOLDER
mkdir -p $FOLDER
unset USER PASSWORD FOLDER UID

telegraf &
exec /usr/sbin/vsftpd -opasv_address=$ADDR /etc/vsftpd/vsftpd.conf
