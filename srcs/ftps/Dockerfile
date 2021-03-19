FROM alpine:latest

RUN apk update && apk add vsftpd openssl openssh

RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=172.17.0.2'

RUN rm /etc/vsftpd/vsftpd.conf
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY script.sh .
RUN chmod 777 script.sh

ENTRYPOINT /script.sh
