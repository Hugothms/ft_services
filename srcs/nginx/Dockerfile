FROM alpine:latest

# Install nginx and its dependencies
RUN apk update && apk add nginx \
&& apk add --no-cache --upgrade bash \
&& apk add openssl openssh \
&& rm -rf /var/cache/apk/*
RUN mkdir -p var/run/nginx

# Install telegraf
# RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/
RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

# SSL Key
RUN mkdir -p /etc/nginx/ssl && openssl req -newkey rsa:2048 -x509 -days 365 -nodes -keyout /etc/nginx/ssl/services.key -out /etc/nginx/ssl/services.pem -subj "/C=FR/ST=Paris/L=Paris/O=42, Inc./OU=hthomas/CN=www.localhost"
RUN usr/bin/ssh-keygen -A

# Nginx config
RUN	rm /etc/nginx/nginx.conf
COPY nginx.conf			/etc/nginx/

RUN echo 'Welcome to ft_services' > /etc/motd

RUN mkdir -p 	/www
COPY index.html	/www/
COPY script.js	/www/

COPY start.sh .
RUN chmod +x start.sh

EXPOSE 80 443

CMD /bin/sh /start.sh
