FROM alpine:latest

RUN	apk update && apk add nginx openrc openssl openssh && apk add wget


RUN apk update \
	&& apk add php7 php7-fpm php7-opcache \
	php7-gd php7-mysqli php7-zlib php7-curl \
	php7-mbstring php7-json php7-session

RUN wget -O wordpress.zip https://wordpress.org/latest.zip \
	&& unzip /wordpress.zip -d / 1> /dev/null  \
	&& rm wordpress.zip \
	&& rm -rf /wordpress/wp-config.php \
	&& rm -rf /var/cache/apk/*

RUN wget http://wordpress.org/latest.tar.gz \
		&& tar xzvf latest.tar.gz \
		&& rm latest.tar.gz

RUN mkdir -p /var/run/nginx
RUN mkdir /var/run/php
RUN rm /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./wp-config.php /wordpress/wp-config.php

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.3_linux_amd64.tar.gz
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

ADD ./start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 5050

CMD ["sh", "./start.sh"]
