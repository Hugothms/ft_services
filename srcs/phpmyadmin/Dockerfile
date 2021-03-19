FROM alpine:latest

RUN apk update
RUN	apk	add openssl openssh	nginx openrc php7 php7-fpm php7-iconv php7-json php7-mbstring php7-mysqli php7-phar php7-session 
RUN rc-update add php-fpm7 default

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && \
		tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && \
                rm phpMyAdmin-5.0.2-all-languages.tar.gz && \
		mv phpMyAdmin-5.0.2-all-languages /phpmyadmin

RUN mkdir -p		/phpmyadmin/tmp
RUN	chmod 777 		/phpmyadmin/tmp
COPY config.inc.php /phpmyadmin/config.inc.php
RUN mkdir -p		/var/run/php
RUN mkdir -p		/var/run/nginx
RUN	rm 				/etc/nginx/conf.d/default.conf
COPY default.conf 	/etc/nginx/conf.d/

RUN adduser -D user42
RUN echo "user42:user42" | chpasswd

RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=172.17.0.2'

ADD start.sh start.sh
RUN chmod +x start.sh

EXPOSE 5000

CMD /bin/sh start.sh
