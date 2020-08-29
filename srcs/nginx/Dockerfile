FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add nginx openrc openssl openssh bash

COPY start_nginx_server.sh	/srcs/
COPY default_on				/etc/nginx/conf.d/default.conf
COPY index.html				/var/www/html/lala.html
COPY ./sshd_config			/etc/ssh/

# CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80 443 30022

ENTRYPOINT /srcs/start_nginx_server.sh
