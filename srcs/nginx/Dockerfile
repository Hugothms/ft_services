FROM alpine

RUN apk update
RUN	apk add bash
RUN	apk add openrc --no-cache
RUN	apk add openssl
RUN	apk add nginx
RUN	apk add openssh

COPY start_nginx_server.sh	/srcs/
COPY default_on				/etc/nginx/conf.d/default.conf
COPY index.html				/var/www/html/index.html
COPY ./sshd_config			/etc/ssh/

# Create SSH user and SSL key
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

EXPOSE 80 443 30022

ENTRYPOINT /srcs/start_nginx_server.sh
