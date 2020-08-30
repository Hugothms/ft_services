FROM alpine

RUN apk update
RUN	apk add openrc --no-cache
RUN	apk add openssl
RUN	apk add nginx
RUN	apk add openssh

RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /www
RUN chown -R www:www /var/lib/nginx
RUN mkdir -p /run/nginx

COPY nginx.conf		/etc/nginx/nginx.conf
#COPY default_on		/etc/nginx/conf.d/default.conf
COPY index.html		/www/index.html
#COPY ./sshd_config	/etc/ssh/

# Create SSH user and SSL key
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

COPY start.sh		/start.sh
RUN chmod +x /start.sh
CMD sh ./start.sh

EXPOSE 80
EXPOSE 443
# EXPOSE 80 443 30022

# ENTRYPOINT /start.sh
