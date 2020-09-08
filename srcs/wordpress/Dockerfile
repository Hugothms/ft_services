FROM alpine:latest

RUN apk update
RUN	apk add wget
RUN	apk add openssl
RUN	apk add php7-fpm

RUN	rm -rf /var/cache/apk/*

COPY start.sh			/
COPY wordpress.tar.gz	/var/www/html/

RUN chmod +x /start.sh

EXPOSE 3306

ENTRYPOINT sh /start.sh
