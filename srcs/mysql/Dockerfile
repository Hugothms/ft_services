FROM alpine

RUN apk update
RUN	apk add mariadb
RUN	apk add mariadb-client

RUN	addgroup mysql mysql
RUN	mkdir /scripts
RUN	rm -rf /var/cache/apk/*

COPY init_docker.sh		/
COPY init_mysql.sql		/

RUN chmod +x /init_docker.sh
RUN chmod +x /init_mysql.sh

EXPOSE 3306

CMD ./init_docker.sh
# ENTRYPOINT bash /srcs/init_docker.sh
