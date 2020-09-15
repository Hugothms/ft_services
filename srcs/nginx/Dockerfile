FROM alpine

RUN apk update
RUN	apk add openrc --no-cache
RUN	apk add openssl
RUN	apk add nginx
RUN	apk add openssh
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /www
RUN chown -R www:www /var/lib/nginx
RUN mkdir -p /run/nginx

COPY nginx.conf		/etc/nginx/nginx.conf
COPY index.html		/www/index.html
COPY script.js		/www/script.js

RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

# Create SSH user and SSL key
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

EXPOSE 80
EXPOSE 443
# EXPOSE 80 443 30022

COPY start.sh		/start.sh
RUN chmod +x /start.sh
CMD sh ./start.sh
# ENTRYPOINT /start.sh
