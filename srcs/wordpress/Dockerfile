FROM alpine:latest

RUN apk update
RUN	apk add bash
RUN	apk add wget 
RUN	apk add openssl

RUN	rm -rf /var/cache/apk/*

COPY start_wordpress_server.sh		/srcs/
COPY wordpress.tar.gz				/var/www/html/

RUN chmod +x /srcs/start_wordpress_server.sh

EXPOSE 3306

ENTRYPOINT bash /srcs/start_wordpress_server.sh
