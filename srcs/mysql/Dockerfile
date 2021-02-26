FROM alpine:latest

RUN apk add --update vim mysql mysql-client 

RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

COPY my.cnf /etc/
COPY start.sh .

COPY init.sql .

EXPOSE 3306

CMD /bin/sh /start.sh
