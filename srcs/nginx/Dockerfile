FROM alpine:latest

# Install nginx and its dependencies
RUN apk update && apk add nginx \
&& apk add --no-cache --upgrade bash \
&& apk add openssl && mkdir -p var/run/nginx \
&& apk add openssl openssh \
&& rm -rf /var/cache/apk/*
RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
# Install telegraf
# RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.3_linux_amd64.tar.gz

RUN mkdir -p /www
COPY index.html		/www/
COPY telegraf.conf /etc/telegraf/

# SSL Key
RUN mkdir -p /etc/nginx/ssl && openssl req -newkey rsa:2048 -x509 -days 365 -nodes -keyout /etc/nginx/ssl/services.key -out /etc/nginx/ssl/services.pem -subj "/C=FR/ST=Paris/L=Paris/O=42, Inc./OU=hthomas/CN=www.localhost"

RUN usr/bin/ssh-keygen -A

# Nginx config
RUN rm /etc/nginx/nginx.conf
COPY nginx.conf	/etc/nginx/

RUN echo 'Welcome to ft_services' > /etc/motd

COPY setup.sh .

RUN chmod +x setup.sh

EXPOSE 80 443
CMD ./setup.sh
