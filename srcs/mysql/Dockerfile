FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add wget openssl bash mysql mysql-client && \
	addgroup mysql mysql && \
	mkdir /scripts && \
	rm -rf /var/cache/apk/*

COPY start_mysql_server.sh			/srcs/
COPY init_mysql.sql					/srcs/

RUN chmod +x /srcs/start_mysql_server.sh

EXPOSE 3306

ENTRYPOINT bash /srcs/start_mysql_server.sh
