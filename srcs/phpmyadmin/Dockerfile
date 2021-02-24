FROM	alpine:latest

RUN apk update
RUN	apk	add openssl openssh	nginx openrc openssl php7 php7-fpm php7-iconv php7-json php7-mbstring php7-mysqli php7-phar php7-session 
RUN rc-update add php-fpm7 default

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && \
		tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && \
                rm phpMyAdmin-5.0.2-all-languages.tar.gz && \
		mv phpMyAdmin-5.0.2-all-languages /phpmyadmin

RUN mkdir /phpmyadmin/tmp
RUN	chmod 777 /phpmyadmin/tmp

RUN mkdir -p /var/run/nginx
RUN mkdir /var/run/php
COPY config.inc.php /phpmyadmin/config.inc.php
RUN	rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf 

RUN adduser -D user
RUN echo "user:password" | chpasswd

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.3_linux_amd64.tar.gz
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

ADD ./start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 5000

CMD ["sh", "./start.sh"]
