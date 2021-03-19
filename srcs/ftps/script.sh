#!/bin/sh

adduser -D user42 && echo "user42:user42" | chpasswd
mkdir -p /home/user42/ftp/files
chmod a-w /home/user42/ftp
chown "nobody:nogroup" /hpme/user42/ftp
chown "user42:user42" /home/user42/ftp/files
echo "test file services" > /home/user42/ftp/files/testfile.txt
telegraf &
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
