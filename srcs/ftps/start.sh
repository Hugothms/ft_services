#!/bin/sh

USER=admin
PASSWORD=admin
FOLDER="/ftp"
ADDR=$(cat ip)

echo -e "$PASSWORD\n$PASSWORD" | adduser -h $FOLDER -s /sbin/nologin -u 1000 $USER

# mkdir -p $FOLDER
chown $USER:$USER $FOLDER
# grep '/ftp/' /etc/passwd | cut -d':' -f1 | xargs -n1 deluser
unset USER PASSWORD FOLDER UID

echo "this is a test file" > /home/user42/ftp/files/test.txt
# echo "set ssl:verify-certificate no" >> ~/.lftp/rc

telegraf &
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

# set ssl:verify-certificate no
# lftp -d -u ftp,alpineftp 192.168.49.2 
