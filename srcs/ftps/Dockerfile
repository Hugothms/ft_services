FROM alpine:latest

RUN apk --no-cache add vsftpd openssl
RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=192.168.49.2'

COPY start.sh		.
COPY vsftpd.conf	/etc/vsftpd/

EXPOSE 20 21

CMD /bin/sh start.sh
