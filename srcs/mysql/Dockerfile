FROM alpine

RUN apk update
RUN	apk add mariadb openrc openssl
RUN	apk add mariadb-client
RUN	apk add mysql
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN	addgroup mysql mysql
RUN	rm -rf /var/cache/apk/*

COPY start.sh			/
COPY init_mysql.sh		/

RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

RUN chmod +x /start.sh
RUN chmod +x /init_mysql.sh

EXPOSE 3306

# CMD ./start.sh
ENTRYPOINT sh /start.sh
