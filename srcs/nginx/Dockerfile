FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add wget nginx openssl bash

COPY start_nginx_server.sh		/srcs/
COPY nginx.conf					/etc/nginx/nginx.conf
COPY defaulton					/etc/nginx/sites-available/default
COPY index.htm					/var/www/html/

EXPOSE 80 443

ENTRYPOINT bash /srcs/start_nginx_server.sh

# FROM alpine:latest

# RUN rm -rf /var/cache/apk/* \
#     && rm -rf /tmp/*

# RUN cat /etc/apk/repositories

# RUN apk add --update gcc \
#                      libc-dev \
#                      linux-headers \
#                      zlib-dev \
#                      openrc \
#                      autoconf \
#                      automake \
#                      git \
#                      libressl-dev \
#                      geoip-dev \
#                      lmdb-dev \
#                      pcre-dev \
#                      libtool \
#                      libxml2-dev \
#                      yajl-dev \
#                      pkgconf \
#                      wget \
#                      zlib-dev \
#                      g++ \
#                      libcurl \
#                      make \
#                      redis


# # Mod_Security Setup
# RUN git clone --depth 1 -b v3/master --single-branch https://github.com/SpiderLabs/ModSecurity
# WORKDIR /ModSecurity
# RUN git submodule init \
#     && git submodule update \
#     && ./build.sh \
#     && ./configure \
#     && make \
#     && make install \
#     && make clean

# WORKDIR /
# RUN git clone --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git \
#     && wget http://nginx.org/download/nginx-1.17.0.tar.gz \
#     && tar zxvf nginx-1.17.0.tar.gz

# WORKDIR /nginx-1.17.0
# RUN  ./configure --with-compat --with-http_ssl_module \
#     && make \
#     && make install \
#     && make clean \
#     && mkdir /etc/nginx \
#     && mkdir /etc/nginx/modules/ \
#     && mkdir /usr/local/nginx/modules/ \
#     && mkdir /var/log/nginx

# RUN ./configure --with-compat --with-http_ssl_module --add-dynamic-module=../ModSecurity-nginx \
#     && make \
#     && make modules \
#     && ls -la /etc/nginx \
#     && cp /nginx-1.17.0/objs/ngx_http_modsecurity_module.so /usr/local/nginx/modules/ngx_http_modsecurity_module.so \
#     && make clean

# WORKDIR /
# RUN mkdir /etc/nginx/modsec \
#     && echo "load_module modules/ngx_http_modsecurity_module.so;" >> /etc/nginx/nginx.conf \
#     && cp /usr/local/nginx/conf/mime.types /etc/nginx/

# ADD nginx_config/modsecurity.conf /etc/nginx/modsec/modsecurity.conf
# ADD nginx_config/modsec.main.conf  /etc/nginx/modsec/main.conf

# # Nginx Config
# ADD nginx_config/my_webapp_nginx.conf /etc/nginx/conf.d/
# ADD nginx_config/nginx.conf /etc/nginx/nginx.conf

# # Install productlisting_framework Libraries
# ENV PYTHONUNBUFFERED 1
# RUN mkdir /run/nginx
# RUN mkdir /my_webapp

# ADD start-nginx-server.sh /my_webapp/

# RUN chmod 777 /my_webapp/start-nginx-server.sh

# EXPOSE 8000
# RUN adduser -D nginx
# ENTRYPOINT /my_webapp/start-nginx-server.sh