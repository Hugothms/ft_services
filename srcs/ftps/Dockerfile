FROM alpine:latest

RUN apk --no-cache add vsftpd openssl
RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

ARG IP
RUN echo $IP > ip

RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=172.17.0.2'
# RUN openssl req -x509 -nodes -days 7300 -subj "/C=FR/ST=Paris/O=21/OU=hthomas/CN=www.localhost" -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

COPY start.sh		.
COPY vsftpd.conf	/etc/vsftpd/

EXPOSE 21 30000

CMD /bin/sh start.sh
