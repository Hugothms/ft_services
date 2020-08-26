FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add nginx openrc openssl openssh bash
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

COPY start_nginx_server.sh		/srcs/
COPY nginx.conf					/etc/nginx/
# COPY default_on					/etc/nginx/sites-available/default
COPY index.html					/var/www/html/
COPY ./sshd_config				/etc/ssh/

EXPOSE 80 443 30022

ENTRYPOINT /srcs/start_nginx_server.sh
