FROM alpine:latest

RUN apk --no-cache add vsftpd openssl
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.3_linux_amd64.tar.gz
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

ARG IP
RUN echo $IP > ip

RUN openssl req -x509 -nodes -days 7300 -subj "/C=FR/ST=Paris/O=21/OU=hthomas/CN=www.localhost" -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY start.sh ./start.sh


EXPOSE 21 30000

CMD ["/bin/sh", "./start.sh"]
