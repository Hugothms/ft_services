FROM alpine

RUN apk update
RUN	apk add openrc
RUN	apk add openssl
RUN	apk add mysql
RUN	apk add mysql-client

RUN	addgroup mysql mysql
RUN	mkdir /scripts
RUN	rm -rf /var/cache/apk/*

COPY start_mysql_server.sh			/srcs/
COPY init_mysql.sql					/srcs/

RUN chmod +x /srcs/start_mysql_server.sh

EXPOSE 3306

ENTRYPOINT bash /srcs/start_mysql_server.sh
