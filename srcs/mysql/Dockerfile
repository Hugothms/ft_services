FROM alpine

RUN apk add --update mysql mysql-client && \
	rm -f /var/cache/apk/*

COPY my.cnf /etc/mysql/my.cnf
COPY entrypoint /entrypoint

RUN mkdir /app

EXPOSE 3306

CMD ./start.sh
# ENTRYPOINT sh /start.sh
